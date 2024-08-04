;; [on-key.fnl]
;; On-keypress mode

(local {: get-locations} (require :eyeliner.liner))
(local {: opts} (require :eyeliner.config))
(local {: ns-id
        : clear-eyeliner
        : apply-eyeliner
        : dim
        : disable-filetypes
        : disable-buftypes} (require :eyeliner.shared))
(local utils (require :eyeliner.utils))

(import-macros {: when-enabled} :fnl/eyeliner/macros)

(fn on-key [key forward?]
  (let [line (utils.get-current-line)
        [y x] (utils.get-cursor)
        dir (if forward? :right :left)
        to-apply (get-locations line x dir)]
    ;; Apply eyeliner right after pressing key
    (if opts.dim (dim y x dir))
    (apply-eyeliner y to-apply)
    (vim.cmd ":redraw") ; :redraw to show highlights
    (clear-eyeliner y)
    key))

(fn enable-keybinds []
  (when-enabled
    (each [_ key (ipairs ["f" "t"])]
      (vim.keymap.set ["n" "x" "o"]
                      key
                      (fn [] (on-key key true))
                      {:buffer 0
                       :expr true}))
    (each [_ key (ipairs ["F" "T"])]
      (vim.keymap.set ["n" "x" "o"]
                      key
                      (fn [] (on-key key false))
                      {:buffer 0
                       :expr true}))))

(fn remove-keybinds []
  (when-enabled
    (each [_ key (ipairs ["f" "F" "t" "T"])]
       (vim.keymap.del ["n" "x" "o"] key {:buffer 0}))))

(fn enable []
  (if opts.debug (vim.notify "On-keypress mode enabled"))
  (disable-filetypes)
  (disable-buftypes)
  (when opts.default_keymaps
    (utils.set-autocmd ["BufEnter"] {:callback enable-keybinds})
    (utils.set-autocmd
      ["BufLeave"]
      {:callback (λ [] (pcall remove-keybinds))})))


{: enable : remove-keybinds}
