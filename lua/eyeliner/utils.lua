local set_autocmd = vim.api.nvim_create_autocmd
local del_augroup = vim.api.nvim_del_augroup_by_name
local create_augroup = vim.api.nvim_create_augroup
local get_current_line = vim.api.nvim_get_current_line
local function get_cursor()
  return vim.api.nvim_win_get_cursor(0)
end
local function get_hl(name)
  return vim.api.nvim_get_hl_by_name(name, true)
end
local function set_hl(name, color)
  return vim.api.nvim_set_hl(0, name, {fg = color, default = true})
end
local function add_hl(ns_id, x)
  local _let_1_ = get_cursor()
  local y = _let_1_[1]
  local _ = _let_1_[2]
  return vim.api.nvim_buf_add_highlight(0, ns_id, "EyelinerPrimary", (y - 1), (x - 1), x)
end
return {["set-autocmd"] = set_autocmd, ["del-augroup"] = del_augroup, ["create-augroup"] = create_augroup, ["get-current-line"] = get_current_line, ["get-cursor"] = get_cursor, ["get-hl"] = get_hl, ["set-hl"] = set_hl, ["add-hl"] = add_hl}
