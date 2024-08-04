;; [shared.fnl]
;; Eyeliner functions shared by the two modes, always-on and on-keypress

(local {: opts} (require :eyeliner.config))
(local utils (require :eyeliner.utils))

;; For syntax highlighting, we create a namespace to group all
;; Eyeliner-related highlights
(local ns-id (vim.api.nvim_create_namespace "eyeliner"))

;; Enable Eyeliner's syntax highlighting, and setup ColorScheme autocmd
(fn enable-highlights []
  (let [primary (utils.get-hl "Constant")
        secondary (utils.get-hl "Define")
        dimmed (utils.get-hl "Comment")]
    (utils.set-hl "EyelinerPrimary" primary.foreground)
    (utils.set-hl "EyelinerSecondary" secondary.foreground)
    (utils.set-hl "EyelinerDimmed" dimmed.foreground)
    (utils.set-autocmd "ColorScheme"
                        {:callback enable-highlights :group "Eyeliner"})))

;; Apply eyeliner (add highlight) for a given y and token
(fn apply-eyeliner [y tokens]
  (fn apply [token]
    (let [{: x : freq} token
          hl-group (if (= freq 1) "EyelinerPrimary" "EyelinerSecondary")]
      (vim.api.nvim_buf_add_highlight 0 ns-id hl-group (- y 1) (- x 1) x)))
  (utils.iter apply tokens))

;; Clear eyeliner (remove highlights) for a given y
(fn clear-eyeliner [y]
  (if (<= y 0)
      (vim.api.nvim_buf_clear_namespace 0 ns-id 0 (+ y 1))
      (vim.api.nvim_buf_clear_namespace 0 ns-id (- y 1) y)))

(fn dim [y x dir]
  (let [line (utils.get-current-line)
        start (if (= dir :right)
                  (+ x 1)
                  (math.max 0 (- x opts.max_length)))
        end (if (= dir :right)
                (math.min (# line) (+ start opts.max_length))
                x)]
    (vim.api.nvim_buf_add_highlight 0 ns-id "EyelinerDimmed" (- y 1) start end)))

;; Disable eyeliner based on filetype
;; Solution: https://stackoverflow.com/a/6496995
(fn disable-filetypes []
  (utils.set-autocmd
    ["FileType"]
    {:pattern (if (utils.empty? opts.disabled_filetypes) "\\%<0" opts.disabled_filetypes)
     :callback (λ [] (set vim.b.eyelinerDisabled true))})) 

(fn disable-buftypes []
  (utils.set-autocmd
    ["BufEnter" "BufWinEnter"]
    {:callback
      (λ []
        (let [bufnr (vim.api.nvim_get_current_buf)
              {: buftype} (. vim.bo bufnr)]
          (when (utils.exists? opts.disabled_buftypes buftype)
            (set vim.b.eyelinerDisabled true))))})) 


{: enable-highlights
 : apply-eyeliner
 : clear-eyeliner
 : disable-filetypes
 : disable-buftypes
 : dim
 : ns-id}
