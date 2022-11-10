(var opts
     {:highlight_on_key false
      :debug false})

(fn setup [user]
  (let [merged (vim.tbl_deep_extend "force" {} opts (or user {}))]
    (if (= merged.debug true) (vim.notify (vim.inspect merged)))
    (set opts merged)))
    
{: setup :opts defaults}
