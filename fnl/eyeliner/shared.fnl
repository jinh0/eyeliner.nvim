;; [shared.fnl]
;; Eyeliner functions shared by the two modes, always-on and on-keypress

(local utils (require :eyeliner.utils))

;; Enable Eyeliner's syntax highlighting, and setup ColorScheme autocmd
(fn enable-highlights []
  (let [primary (utils.get-hl "Constant")
        secondary (utils.get-hl "Define")]
    (utils.set-hl "EyelinerPrimary" primary.foreground)
    (utils.set-hl "EyelinerSecondary" secondary.foreground)
    (utils.set-autocmd "ColorScheme"
                       {:callback enable-highlights :group "Eyeliner"}))) 


;; TODO
(fn remove-keybinds []
  (let [opts (. (require "eyeliner.config") :opts)]
    (if opts.highlight-on-key
        (print "todo: remove-keybinds"))))

;; TODO
(fn apply-eyeliner [locations] nil)

;; TODO
(fn clear-eyeliner []
  (vim.notify "todo: clear-eyeliner"))


{: enable-highlights
 : remove-keybinds
 : apply-eyeliner
 : clear-eyeliner}
