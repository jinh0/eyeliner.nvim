;; [always-on.fnl]
;; Always-on mode

(local liner (require :eyeliner.liner))
(local utils (require :eyeliner.utils))
(local {: apply-eyeliner} (require :eyeliner.shared))
    
;; TODO: Only traverses through right
;; returns list of locations to apply eyeliner to
(fn traverse [line x]
  nil)

;; TODO
(fn handle-hover []
  (let [line (utils.get-current-line)
        [y x] (utils.get-cursor)
        locations (traverse line x)]
    ; (apply-eyeliner locations)))
    locations))

;; Set Eyeliner to always-on mode
(fn enable []
  (utils.set-autocmd ["CursorMoved" "WinScrolled" "BufReadPost"]
                     {:callback handle-hover :group "Eyeliner"}))


{: enable}
