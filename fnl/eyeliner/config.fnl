;; [config.fnl]
;; Configuration options & setup

(var opts {:highlight_on_key false :dim false :debug false})

(fn setup [user]
  (let [{: enabled : enable : disable} (require :eyeliner.main)
        ;; merged = union of default options and user's options
        merged (vim.tbl_deep_extend "force" {} opts (or user {}))]
    (if enabled (disable)) ; See https://github.com/jinh0/eyeliner.nvim/pull/19
    (set opts.highlight_on_key merged.highlight_on_key)
    (set opts.dim merged.dim)
    (set opts.debug merged.debug)
    (enable)))


{: setup : opts}
