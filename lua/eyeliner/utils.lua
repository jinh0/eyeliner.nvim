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
local function add_hl(ns_id, hl_group, x)
  local _let_1_ = get_cursor()
  local y = _let_1_[1]
  local _ = _let_1_[2]
  return vim.api.nvim_buf_add_highlight(0, ns_id, hl_group, (y - 1), x, (x + 1))
end
local function map(f, list)
  local tbl_15_auto = {}
  local i_16_auto = #tbl_15_auto
  for _, val in ipairs(list) do
    local val_17_auto = f(val)
    if (nil ~= val_17_auto) then
      i_16_auto = (i_16_auto + 1)
      do end (tbl_15_auto)[i_16_auto] = val_17_auto
    else
    end
  end
  return tbl_15_auto
end
local function filter(f, list)
  local tbl_15_auto = {}
  local i_16_auto = #tbl_15_auto
  for _, val in ipairs(list) do
    local val_17_auto
    if f(val) then
      val_17_auto = val
    else
      val_17_auto = nil
    end
    if (nil ~= val_17_auto) then
      i_16_auto = (i_16_auto + 1)
      do end (tbl_15_auto)[i_16_auto] = val_17_auto
    else
    end
  end
  return tbl_15_auto
end
local function iter(f, list)
  for _, val in ipairs(list) do
    f(val)
  end
  return nil
end
local function some_3f(f, list)
  local status = false
  for _, val in ipairs(list) do
    if f(val) then
      status = true
    else
    end
  end
  return status
end
return {["set-autocmd"] = set_autocmd, ["del-augroup"] = del_augroup, ["create-augroup"] = create_augroup, ["get-current-line"] = get_current_line, ["get-cursor"] = get_cursor, ["get-hl"] = get_hl, ["set-hl"] = set_hl, ["add-hl"] = add_hl, map = map, filter = filter, iter = iter, ["some?"] = some_3f}
