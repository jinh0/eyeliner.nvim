;; [liner.fnl]
;; Main algorithm for calculating which characters to highlight

(local {: str->list : alphanumeric? : alphabetic?} (require "eyeliner.string"))
(local {: map : filter : some?} (require "eyeliner.utils"))

;; type Token = { x: number, freq: number, char: string }

;; Converts the substring of the line from x onwards
;; into a list of tokens: Every token contains information
;; about every character's x-coordinate and its cumulative frequency.
;; Order of characters in the string is maintained in the new list of tokens.
;;
;; Returns Token[]
(fn get-tokens [line x dir]
  ;; Iterate through the string line with the right step depending on the direction
  (local go-right? (= dir :right))
  (local step (if go-right? 1 -1))

  ;; Get the first x-coordinate to start reading tokens, i.e., "proper".
  ;; The first proper coordinate is the first coordinate after the end
  ;; of the current word the cursor is on.
  (fn get-first-proper []
    (var idx (+ x 1)) ; start at x + 1 due to Lua indexing (starts with 1 not 0)
    (while (and (alphanumeric? (line:sub idx idx))
                (if go-right? (<= idx (# line)) (>= idx 1)))
      (set idx (+ idx step)))
    idx)

  ;; Reverse list helper function
  (fn reversed [list]
    (let [new-list []]
      (for [idx (# list) 1 -1]
        (table.insert new-list (. list idx)))
      new-list))

  (let [freqs {}
        tokens []
        line (str->list line)
        first-proper (get-first-proper)
        start (if go-right? (+ x 2) x)
        end (if go-right? (# line) 1)]
    (for [idx start end step]
      (if (not (= (. line idx) nil))
          (let [char (. line idx)
                freq (. freqs char)]
            (if (= freq nil)
                (tset freqs char 1)
                (tset freqs char (+ 1 freq)))
            (table.insert tokens {:x idx :freq (. freqs char) : char}))))
    ;; We need to remove all the characters of the word the cursor is on.
    ;; Reverse the list if going left to prioritize earlier (more to the left) letters
    (filter (λ [token]
              (if go-right?
                  (>= token.x first-proper)
                  (<= token.x first-proper)))
            (if go-right? tokens (reversed tokens)))))

;; Join a list of tokens into a list of words, where a word
;; is its own list of tokens (i.e., Token[]).
;; Note: Empty words are discarded
;;
;; Returns Token[][]
(fn tokens->words [tokens]
  (let [words []
        not-empty? (λ [word] (not= (length word) 0))]
    (var word [])
    (each [idx token (ipairs tokens)]
      (if (not (alphanumeric? token.char)) ; not alphanumeric = divider
          (do (table.insert words word) ; add to the list of words
              (set word []))
          (table.insert word token)))
    (table.insert words word)
    (filter not-empty? words)))

;; Get the tokens to highlight (to put eyeliner on)
;; Returns Token[]
(fn get-locations [line x dir] ; dir = direction (:left | :right)
  ;; Get token with minimum frequency in a word
  (fn min-token [word]
    (let [valid-tokens (filter (λ [token] (alphabetic? token.char)) word)]
      (accumulate [min {:freq 9999999} _ token (ipairs valid-tokens)]
        (if (< token.freq min.freq) token min))))

  (let [tokens (get-tokens line x dir)
        words (tokens->words tokens)
        min-tokens (map min-token words)
        ;; We only highlight if frequency is <= 2
        ;; Maybe we should highlight red (or some special color) for freq > 2?
        valid? (λ [token] (<= token.freq 2))]
    (filter valid? min-tokens)))


{: get-locations}
