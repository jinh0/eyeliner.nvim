local _local_1_ = require("eyeliner.liner")
local get_locations = _local_1_["get-locations"]
local _local_2_ = require("eyeliner.config")
local opts = _local_2_["opts"]
local _local_3_ = require("eyeliner.shared")
local clear_eyeliner = _local_3_["clear-eyeliner"]
local apply_eyeliner = _local_3_["apply-eyeliner"]
local dim = _local_3_["dim"]
local disable_filetypes = _local_3_["disable-filetypes"]
local disable_buftypes = _local_3_["disable-buftypes"]
local utils = require("eyeliner.utils")
local prev_y = nil
local cleanup_3f = false
local function highlight(_4_)
  local forward_3f = _4_["forward"]
  local line = utils["get-current-line"]()
  local _let_5_ = utils["get-cursor"]()
  local y = _let_5_[1]
  local x = _let_5_[2]
  local dir
  if forward_3f then
    dir = "right"
  else
    dir = "left"
  end
  local to_apply = get_locations(line, x, dir)
  if opts.dim then
    dim(y, x, dir)
  else
  end
  apply_eyeliner(y, to_apply)
  prev_y = y
  cleanup_3f = true
  return vim.cmd(":redraw")
end
local function on_key(key, forward_3f)
  highlight(forward_3f)
  return key
end
local function enable_keybinds()
  if not vim.b[vim.api.nvim_get_current_buf()].eyelinerDisabled then
    local default_keys = {"f", "t", "F", "T"}
    local enabled_keys
    if (true == opts.highlight_on_key) then
      enabled_keys = default_keys
    else
      enabled_keys = opts.highlight_on_key
    end
    for _, key in ipairs(enabled_keys) do
      if ((key == "f") or (key == "t")) then
        local function _9_()
          return on_key(key, {forward = true})
        end
        vim.keymap.set({"n", "x", "o"}, key, _9_, {buffer = 0, expr = true})
      else
      end
    end
    for _, key in ipairs(enabled_keys) do
      if ((key == "F") or (key == "T")) then
        local function _11_()
          return on_key(key, {forward = false})
        end
        vim.keymap.set({"n", "x", "o"}, key, _11_, {buffer = 0, expr = true})
      else
      end
    end
    return nil
  else
    return nil
  end
end
local function remove_keybinds()
  if not vim.b[vim.api.nvim_get_current_buf()].eyelinerDisabled then
    for _, key in ipairs({"f", "F", "t", "T"}) do
      vim.keymap.del({"n", "x", "o"}, key, {buffer = 0})
    end
    return nil
  else
    return nil
  end
end
local function enable()
  if opts.debug then
    vim.notify("On-keypress mode enabled")
  else
  end
  disable_filetypes()
  disable_buftypes()
  local function _16_()
    if cleanup_3f then
      clear_eyeliner(prev_y)
      cleanup_3f = false
      return nil
    else
      return nil
    end
  end
  utils["set-autocmd"]({"CursorMoved"}, {callback = _16_})
  local function _18_(char)
    local key = vim.fn.keytrans(char)
    if (key == "<Esc>") then
      if cleanup_3f then
        clear_eyeliner(prev_y)
        cleanup_3f = false
        return nil
      else
        return nil
      end
    else
      return nil
    end
  end
  vim.on_key(_18_, vim.api.nvim_get_current_buf())
  if opts.default_keymaps then
    enable_keybinds()
    utils["set-autocmd"]({"BufEnter"}, {callback = enable_keybinds})
    local function _21_()
      return pcall(remove_keybinds)
    end
    return utils["set-autocmd"]({"BufLeave"}, {callback = _21_})
  else
    return nil
  end
end
return {enable = enable, ["remove-keybinds"] = remove_keybinds, highlight = highlight}
