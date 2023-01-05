;; [utils.fnl]
;; Shorthand versions of vim API

(local set-autocmd vim.api.nvim_create_autocmd)
(local del-augroup vim.api.nvim_del_augroup_by_name)
(local create-augroup vim.api.nvim_create_augroup)
(local get-current-line vim.api.nvim_get_current_line)

(fn get-cursor []
  (vim.api.nvim_win_get_cursor 0))

(fn get-hl [name]
  (vim.api.nvim_get_hl_by_name name true))

(fn set-hl [name color]
  (vim.api.nvim_set_hl 0 name {:fg color :default true}))

(fn add-hl [ns-id x]
  (let [[y _] (get-cursor)]
    (vim.api.nvim_buf_add_highlight 0 ns-id "EyelinerPrimary" (- y 1) (- x 1) x)))


{: set-autocmd
 : del-augroup
 : create-augroup
 : get-current-line
 : get-cursor
 : get-hl
 : set-hl
 : add-hl}
