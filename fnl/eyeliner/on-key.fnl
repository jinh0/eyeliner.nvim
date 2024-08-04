;; [on-key.fnl]
;; On-keypress mode

(local {: get-locations} (require :eyeliner.liner))
(local {: opts} (require :eyeliner.config))
(local {: clear-eyeliner
        : apply-eyeliner
        : dim
        : disable-filetypes
        : disable-buftypes} (require :eyeliner.shared))
(local utils (require :eyeliner.utils))

(import-macros {: when-enabled} :fnl/eyeliner/macros)

(var prev-y nil)
(var cleanup? false)

;; This is a public function!
(fn highlight [{:forward forward?}]
  (let [line (utils.get-current-line)
        [y x] (utils.get-cursor)
        dir (if forward? :right :left)
        to-apply (get-locations line x dir)]
    ;; Apply eyeliner right after pressing key
    (if opts.dim (dim y x dir))
    (apply-eyeliner y to-apply)
    (set prev-y y)
    (set cleanup? true)
    (vim.cmd ":redraw"))) ; :redraw to show highlights
    ; (clear-eyeliner y)))

(fn on-key [key forward?]
  (highlight forward?)
  key)

(fn enable-keybinds []
  (when-enabled
    (each [_ key (ipairs ["f" "t"])]
      (vim.keymap.set ["n" "x" "o"]
                      key
                      (fn [] (on-key key {:forward true}))
                      {:buffer 0
                       :expr true}))
    (each [_ key (ipairs ["F" "T"])]
      (vim.keymap.set ["n" "x" "o"]
                      key
                      (fn [] (on-key key {:forward false}))
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
  (utils.set-autocmd
    ["CursorMoved"]
    {:callback
      (λ []
        (when cleanup?
          (clear-eyeliner prev-y)
          (set cleanup? false)))})
  (when opts.default_keymaps
    (utils.set-autocmd ["BufEnter"] {:callback enable-keybinds})
    (utils.set-autocmd
      ["BufLeave"]
      {:callback (λ [] (pcall remove-keybinds))})))


{: enable : remove-keybinds : highlight}
