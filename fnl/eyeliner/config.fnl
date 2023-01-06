;; [config.fnl]
;; Configuration options & setup

(var opts {:highlight_on_key false :debug false})

(fn setup [user]
  ;; merged = union of default options and user's options
  (let [merged (vim.tbl_deep_extend "force" {} opts (or user {}))]
    (set opts.highlight_on_key merged.highlight_on_key)
    (set opts.debug merged.debug)))


{: setup : opts}
