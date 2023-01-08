;; [on-key.fnl]
;; On-keypress mode

(local {: get-locations} (require :eyeliner.liner))
(local {: opts} (require :eyeliner.config))
(local {: ns-id : clear-eyeliner : apply-eyeliner} (require :eyeliner.shared))
(local utils (require :eyeliner.utils))
(local {: iter} utils)

;; Returns the function that will run when the key is pressed
(fn handle-keypress [key operator]
  ;; Pressing <Esc> after key cannot be listened to unless we handle it using
  ;; getcharstr() as a preliminary step. This is the purpose of simulate-find.
  (fn simulate-find []
    (let [char (vim.fn.getcharstr)]
      (if operator (vim.api.nvim_feedkeys operator "n" true))
      (vim.api.nvim_feedkeys key "n" true)
      (vim.api.nvim_feedkeys char "n" true)))

  (fn on-key []
    (let [line (utils.get-current-line)
          [y x] (utils.get-cursor)
          dir (if (or (= key "f") (= key "t")) :right :left)
          to-apply (get-locations line x dir)]
      ;; Apply eyeliner right after pressing key
      (iter (λ [token] (apply-eyeliner y token)) to-apply)
      ;; Draw fake cursor, since getcharstr() will move the real cursor away
      (utils.add-hl ns-id "Cursor" x)
      (vim.cmd ":redraw") ; :redraw to show Cursor highlight
      (pcall simulate-find)
      (clear-eyeliner y)))

  on-key)

(fn enable []
  (each [_ key (ipairs ["f" "F" "t" "T"])]
    ;; Normal keypresses
    (vim.keymap.set ["n" "x"]
                    key
                    (handle-keypress key nil))
    ;; Operator-pending keypresses
    (each [_ operator (ipairs ["d" "y"])]
      (vim.keymap.set ["n"]
                      (.. operator key)
                      (handle-keypress key operator)))))

(fn remove-keybinds []
  (each [_ key (ipairs ["f" "F" "t" "T"])]
    (vim.keymap.del ["n" "x"] key)
    (each [_ operator (ipairs ["d" "y"])]
      (vim.keymap.del ["n"] (.. operator key)))))


{: enable
 : remove-keybinds}
