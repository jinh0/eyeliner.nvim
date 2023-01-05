;; [always-on.fnl]
;; Always-on mode

(local liner (require :eyeliner.liner))
(local utils (require :eyeliner.utils))
(local {: apply-eyeliner} (require :eyeliner.shared))

; TODO
(fn hl-words [scores]
  (each [idx val (ipairs scores)]
    nil)
  scores)
    
; TODO: Only traverses through right
(fn traverse [line x]
  (let [scores (liner.get-scores line x)]
    (hl-words scores)))

; TODO
(fn handle-hover []
  (let [line (utils.get-current-line)
        [y x] (utils.get-cursor)
        to-apply (traverse line x)]
    (apply-eyeliner to-apply)))

;; Set Eyeliner to always-on mode
(fn enable []
  (vim.notify "always on")
  (utils.set-autocmd ["CursorMoved" "WinScrolled" "BufReadPost"]
                     {:callback handle-hover :group "Eyeliner"}))


{: enable}
