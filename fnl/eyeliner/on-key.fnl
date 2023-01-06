;; [on-key.fnl]
;; On-keypress mode

(fn enable []
  (vim.notify "todo"))

;; TODO
(fn remove-keybinds []
  (let [{: opts} (require "eyeliner.config")]
    (if opts.highlight-on-key
        (vim.notify "todo: remove-keybinds"))))


{: enable
 : remove-keybinds}
