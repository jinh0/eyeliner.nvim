local ns_id = vim.api.nvim_create_namespace("eyeliner")
local utils = require("eyeliner.utils")
local liner = require("eyeliner.liner")
local function apply_eyeliner(locations)
  return nil
end
local function hl_words(scores)
  for idx, val in ipairs(scores) do
  end
  return scores
end
local function traverse(line, x)
  local scores = liner["get-scores"](line, x)
  return hl_words(scores)
end
local function handle_hover()
  local line = __fnl_global__get_2dcurrent_2dline()
  local _let_1_ = __fnl_global__get_2dcursor()
  local y = _let_1_[1]
  local x = _let_1_[2]
  local to_apply = traverse(line, x)
  return apply_eyeliner(to_apply)
end
local function enable_highlights()
  local primary = utils["get-hl"]("Constant")
  local secondary = utils["get-hl"]("Define")
  utils["set-hl"]("EyelinerPrimary", primary.foreground)
  utils["set-hl"]("EyelinerSecondary", secondary.foreground)
  return utils["set-autocmd"]("ColorScheme", {group = "Eyeliner", callback = enable_highlights})
end
local function enable_on_key()
  return vim.notify("todo")
end
local function enable_always_on()
  vim.notify("always on")
  return utils["set-autocmd"]({"CursorMoved", "WinScrolled", "BufReadPost"}, {group = "Eyeliner", callback = handle_hover})
end
local function clear_eyeliner()
  return vim.notify("todo: clear-eyeliner")
end
local function remove_keybinds()
  local opts = (require("eyeliner.config")).opts
  if opts["highlight-on-key"] then
    return print("todo: remove-keybinds")
  else
    return nil
  end
end
local enabled = false
local function enable()
  if not enabled then
    local opts = (require("eyeliner.config")).opts
    utils["create-augroup"]("Eyeliner", {})
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
    utils["del-augroup"]("Eyeliner")
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
