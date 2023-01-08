;; [string.fnl]
;; String helper functions

(fn str->list [str]
  (let [tbl {}]
    (for [i 1 (# str)]
      (table.insert tbl (str:sub i i)))
    tbl))

(fn alphanumeric? [char]
  (char:match "%w"))

(fn alphabetic? [char]
  (char:match "[A-Za-z]"))


{: str->list : alphanumeric? : alphabetic?}
