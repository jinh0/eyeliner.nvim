;; [always-on.fnl]
;; Always-on mode

(local {: get-locations} (require :eyeliner.liner))
(local {: apply-eyeliner : clear-eyeliner} (require :eyeliner.shared))
(local utils (require :eyeliner.utils))
(local {: iter} utils)

;; We need to keep track of the previous y-coordinate of the user,
;; so that we can clear the eyeliner applied on the previous line.
(var prev-y 0)

;; This function runs every time the cursor moves (TODO: better name?).
;; It clears the previous highlights and adds new highlights on the current line.
(fn handle-hover []
  (let [line (utils.get-current-line)
        [y x] (utils.get-cursor)
        left (get-locations line x :left)
        right (get-locations line x :right)]
    (clear-eyeliner prev-y)
    (iter (λ [token] (apply-eyeliner y token)) left)
    (iter (λ [token] (apply-eyeliner y token)) right)
    (set prev-y y)))

;; Set Eyeliner to always-on mode
(fn enable []
  ;; Hover autocmd
  (utils.set-autocmd ["CursorMoved" "WinScrolled" "BufReadPost"]
                     {:callback handle-hover :group "Eyeliner"})
  ;; Autocmd to clear eyeliner on InsertEnter
  (utils.set-autocmd ["InsertEnter"]
                     {:callback (λ [] (clear-eyeliner prev-y))
                      :group "Eyeliner"}))
                      


{: enable}
