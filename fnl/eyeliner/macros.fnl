;; fennel-ls: macro-file

;; TODO: I know this looks ugly but fennel-ls will get angry at me if not
(fn when-enabled [body]
  `(when (not (. (. vim.b (vim.api.nvim_get_current_buf)) :eyelinerDisabled))
     ,body))

{: when-enabled}
