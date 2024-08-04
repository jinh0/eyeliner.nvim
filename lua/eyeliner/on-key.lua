local _local_1_ = require("eyeliner.liner")
local get_locations = _local_1_["get-locations"]
local _local_2_ = require("eyeliner.config")
local opts = _local_2_["opts"]
local _local_3_ = require("eyeliner.shared")
local ns_id = _local_3_["ns-id"]
local clear_eyeliner = _local_3_["clear-eyeliner"]
local apply_eyeliner = _local_3_["apply-eyeliner"]
local dim = _local_3_["dim"]
local disable_filetypes = _local_3_["disable-filetypes"]
local disable_buftypes = _local_3_["disable-buftypes"]
local utils = require("eyeliner.utils")
local function on_key(key, forward_3f)
  local line = utils["get-current-line"]()
  local _let_4_ = utils["get-cursor"]()
  local y = _let_4_[1]
  local x = _let_4_[2]
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
  vim.cmd(":redraw")
  clear_eyeliner(y)
  return key
end
local function enable_keybinds()
  if not vim.b[vim.api.nvim_get_current_buf()].eyelinerDisabled then
    for _, key in ipairs({"f", "t"}) do
      local function _7_()
        return on_key(key, true)
      end
      vim.keymap.set({"n", "x", "o"}, key, _7_, {buffer = 0, expr = true})
    end
    for _, key in ipairs({"F", "T"}) do
      local function _8_()
        return on_key(key, false)
      end
      vim.keymap.set({"n", "x", "o"}, key, _8_, {buffer = 0, expr = true})
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
  if opts.default_keymaps then
    utils["set-autocmd"]({"BufEnter"}, {callback = enable_keybinds})
    local function _12_()
      return pcall(remove_keybinds)
    end
    return utils["set-autocmd"]({"BufLeave"}, {callback = _12_})
  else
    return nil
  end
end
return {enable = enable, ["remove-keybinds"] = remove_keybinds}
