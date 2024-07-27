;; [config.fnl]
;; Configuration options & setup

(var opts {:highlight_on_key false :dim false :debug false :match "[A-Za-z]"})

(fn setup [user]
  (let [{: enabled? : enable : disable} (require :eyeliner.main)
        ;; merged = union of default options and user's options
        merged (vim.tbl_deep_extend "force" {} opts (or user {}))]
    (if (enabled?) (disable)) ; See https://github.com/jinh0/eyeliner.nvim/pull/19
    (each [key value (pairs merged)]
      (tset opts key value))
    (if opts.debug (vim.notify "Eyeliner debug mode enabled"))
    (enable)))


{: setup : opts}
