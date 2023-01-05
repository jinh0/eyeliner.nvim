;; [liner.fnl]
;; Main algorithm for calculating which characters to highlight

(local {: str->list} (require "eyeliner.string"))

(fn get-scores [line x]
  (let [freqs {}
        scores []
        line (str->list line)]
    (for [i (+ x 1) (# line)]
      (let [char (. line i)]
        (if (= (. freqs char) nil)
            (tset freqs char 1)
            (tset freqs char (+ 1 (. freqs char))))
        (table.insert scores
                      {:x i
                       :score (. freqs char)
                       :char char})))
    scores))


{: get-scores}
