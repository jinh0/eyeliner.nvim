;; [always-on.fnl]
;; Always-on mode

(local {: get-locations} (require :eyeliner.liner))
(local {: apply-eyeliner
        : clear-eyeliner
        : disable-filetypes
        : disable-buftypes} (require :eyeliner.shared))
(local {: opts} (require :eyeliner.config))
(local utils (require :eyeliner.utils))

(import-macros {: when-enabled} :fnl/eyeliner/macros)

;; We need to keep track of the previous y-coordinate of the user,
;; so that we can clear the eyeliner applied on the previous line.
(var prev-y 0)

;; This function runs every time the cursor moves (TODO: better name?).
;; It clears the previous highlights and adds new highlights on the current line.
(fn handle-hover []
  (when-enabled
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
  (disable-filetypes)
  (disable-buftypes)
  ;; Hover autocmd
  (utils.set-autocmd ["CursorMoved" "WinScrolled" "BufReadPost"]
                     {:callback handle-hover})
  ;; Autocmd to clear eyeliner on InsertEnter and BufLeave
  (utils.set-autocmd ["InsertEnter" "BufLeave" "BufWinLeave"]
                     {:callback (λ [] (clear-eyeliner prev-y))}))


{: enable}
