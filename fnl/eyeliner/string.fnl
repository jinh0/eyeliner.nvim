;; [string.fnl]
;; String helper functions

(fn str->list [str]
  (let [tbl {}]
    (for [i 1 (# str)]
      (table.insert tbl (str:sub i i)))
    tbl))


{: str->list}
