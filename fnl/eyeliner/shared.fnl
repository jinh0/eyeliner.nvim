;; [shared.fnl]
;; Eyeliner functions shared by the two modes, always-on and on-keypress

(local utils (require :eyeliner.utils))

;; For syntax highlighting, we create a namespace which allows us
;; to easily clear all Eyeliner-related highlights
(local ns-id (vim.api.nvim_create_namespace "eyeliner"))

;; Enable Eyeliner's syntax highlighting, and setup ColorScheme autocmd
(fn enable-highlights []
  (let [primary (utils.get-hl "Constant")
        secondary (utils.get-hl "Define")]
    (utils.set-hl "EyelinerPrimary" primary.foreground)
    (utils.set-hl "EyelinerSecondary" secondary.foreground)
    (utils.set-autocmd "ColorScheme"
                       {:callback enable-highlights :group "Eyeliner"}))) 

;; TODO
(fn apply-eyeliner [y {: x : freq}]
  (let [hl-group (if (= freq 1) "EyelinerPrimary" "EyelinerSecondary")]
    (vim.api.nvim_buf_add_highlight 0 ns-id hl-group (- y 1) (- x 1) x)))

;; TODO
(fn clear-eyeliner [y]
  (if (<= y 0)
      (vim.api.nvim_buf_clear_namespace 0 ns-id 0 (+ y 1))
      (vim.api.nvim_buf_clear_namespace 0 ns-id (- y 1) y)))


{: enable-highlights
 : apply-eyeliner
 : clear-eyeliner}