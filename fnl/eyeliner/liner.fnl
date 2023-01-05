(fn str->list [str]
  (let [tbl {}]
    (for [i 1 (# str)]
      (table.insert tbl (str:sub i i)))
    tbl))

(fn get-scores [line x]
  (let [freqs {}
        scores []
        line (str->list line)]
    (for [i (+ x 1) (# line)]
      (let [char (. line i)]
        (if (= (. freqs char) nil)
            (tset freqs char 1)
            (tset freqs char (+ 1 (. freqs char))))
        (table.insert scores {:x i :s (. freqs char) :c char})))
    scores))


{: str->list
 : get-scores}
