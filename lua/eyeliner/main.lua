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
local function str__3elist(str)
  local tbl = {}
  for i = 1, #str do
    table.insert(tbl, str:sub(i, i))
  end
  return tbl
end
str__3elist("asdf")
local function apply_eyeliner(locations)
  return vim.notify("todo")
end
local function traverse(line, x)
  local freqs = {}
  local line0 = str__3elist(line)
  for i = (x + 1), #line0 do
    print((line0)[i])
  end
  return nil
end
traverse(get_current_line(), get_cursor()[2])
local function handle_hover()
  local line = get_current_line()
  local _let_1_ = get_cursor()
  local y = _let_1_[1]
  local x = _let_1_[2]
  local to_apply = traverse(line, x)
  return apply_eyeliner(to_apply)
end
local function enable_highlights()
  local primary = get_hl("Constant")
  local secondary = get_hl("Define")
  set_hl("EyelinerPrimary", primary.foreground)
  set_hl("EyelinerSecondary", secondary.foreground)
  return set_autocmd("ColorScheme", {group = "Eyeliner", callback = enable_highlights})
end
local function enable_on_key()
  return vim.notify("todo")
end
local function enable_always_on()
  return set_autocmd({"CursorMoved", "WinScrolled", "BufReadPost"}, {group = "Eyeliner", callback = handle_hover})
end
local function clear_eyeliner()
  return vim.notify("todo")
end
local function remove_keybinds()
  local opts = (require("eyeliner.config")).opts
  if opts["highlight-on-key"] then
    return print("todo")
  else
    return nil
  end
end
local enabled = true
local function enable()
  if not enabled then
    local opts = (require("eyeliner.config")).opts
    create_augroup("Eyeliner", {})
    enable_highlights()
    if opts["highlight-on-key"] then
      enable_on_key()
    else
      enable_always_on()
    end
    enabled = true
    return true
  else
    return false
  end
end
local function disable()
  if enabled then
    remove_keybinds()
    clear_eyeliner()
    del_augroup("Eyeliner")
    enabled = false
    return nil
  else
    return false
  end
end
local function toggle()
  if enabled then
    return enable()
  else
    return disable()
  end
end
return {enable = enable, disable = disable, toggle = toggle}
