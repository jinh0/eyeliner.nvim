;; [string.fnl]
;; String helper functions

(fn str->list [str]
  (let [tbl {}]
    (for [i 1 (# str)]
      (table.insert tbl (str:sub i i)))
    tbl))

(local dividers
       {"(" true
        ")" true
        "[" true
        "]" true
        "{" true
        "}" true
        ":" true
        "." true
        "," true
        "?" true
        "!" true
        ";" true
        "-" true
        "_" true
        "|" true
        " " true
        "#" true})

(fn divider? [char]
  (= (. dividers char) true))


{: str->list : divider?}
