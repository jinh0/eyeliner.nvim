local function set_autocmd(event, opts)
  local merged = vim.tbl_deep_extend("force", {group = "Eyeliner"}, opts)
  return vim.api.nvim_create_autocmd(event, merged)
end
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
  return vim.api.nvim_set_hl(0, name, {fg = color, force = true})
end
local function add_hl(ns_id, hl_group, x)
  local _let_1_ = get_cursor()
  local y = _let_1_[1]
  local _ = _let_1_[2]
  return vim.api.nvim_buf_add_highlight(0, ns_id, hl_group, (y - 1), x, (x + 1))
end
local function map(f, list)
  local tbl_19_auto = {}
  local i_20_auto = 0
  for _, val in ipairs(list) do
    local val_21_auto = f(val)
    if (nil ~= val_21_auto) then
      i_20_auto = (i_20_auto + 1)
      do end (tbl_19_auto)[i_20_auto] = val_21_auto
    else
    end
  end
  return tbl_19_auto
end
local function filter(f, list)
  local tbl_19_auto = {}
  local i_20_auto = 0
  for _, val in ipairs(list) do
    local val_21_auto
    if f(val) then
      val_21_auto = val
    else
      val_21_auto = nil
    end
    if (nil ~= val_21_auto) then
      i_20_auto = (i_20_auto + 1)
      do end (tbl_19_auto)[i_20_auto] = val_21_auto
    else
    end
  end
  return tbl_19_auto
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
local function exists_3f(list, x)
  local function _6_(y)
    _G.assert((nil ~= y), "Missing argument y on fnl/eyeliner/utils.fnl:50")
    return (y == x)
  end
  return some_3f(_6_, list)
end
local function empty_3f(list)
  return (#list == 0)
end
return {["set-autocmd"] = set_autocmd, ["del-augroup"] = del_augroup, ["create-augroup"] = create_augroup, ["get-current-line"] = get_current_line, ["get-cursor"] = get_cursor, ["get-hl"] = get_hl, ["set-hl"] = set_hl, ["add-hl"] = add_hl, map = map, filter = filter, iter = iter, ["some?"] = some_3f, ["exists?"] = exists_3f, ["empty?"] = empty_3f}
