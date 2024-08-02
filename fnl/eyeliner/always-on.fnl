;; [always-on.fnl]
;; Always-on mode

(local {: get-locations} (require :eyeliner.liner))
(local {: apply-eyeliner : clear-eyeliner} (require :eyeliner.shared))
(local {: opts} (require :eyeliner.config))
(local utils (require :eyeliner.utils))

;; We need to keep track of the previous y-coordinate of the user,
;; so that we can clear the eyeliner applied on the previous line.
(var prev-y 0)

;; This function runs every time the cursor moves (TODO: better name?).
;; It clears the previous highlights and adds new highlights on the current line.
(fn handle-hover []
  (local cur_bufnr (vim.api.nvim_get_current_buf))
  (when (not (utils.exists? opts.disabled_filetypes (. (. vim.bo cur_bufnr) :filetype)))
    (let [line (utils.get-current-line)
          [y x] (utils.get-cursor)
          left (get-locations line x :left)
          right (get-locations line x :right)]
      (clear-eyeliner prev-y)
      (apply-eyeliner y left)
      (apply-eyeliner y right)
      (set prev-y y))))

;; Set Eyeliner to always-on mode
(fn enable []
  (if opts.debug (vim.notify "Always-on mode enabled"))
  ;; Hover autocmd
  (utils.set-autocmd ["CursorMoved" "WinScrolled" "BufReadPost"]
                     {:callback handle-hover :group "Eyeliner"})
  ;; Autocmd to clear eyeliner on InsertEnter
  (utils.set-autocmd ["InsertEnter"]
                     {:callback (λ [] (clear-eyeliner prev-y))
                      :group "Eyeliner"}))


{: enable}
