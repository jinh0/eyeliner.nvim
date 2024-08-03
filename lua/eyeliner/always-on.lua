local _local_1_ = require("eyeliner.liner")
local get_locations = _local_1_["get-locations"]
local _local_2_ = require("eyeliner.shared")
local apply_eyeliner = _local_2_["apply-eyeliner"]
local clear_eyeliner = _local_2_["clear-eyeliner"]
local _local_3_ = require("eyeliner.config")
local opts = _local_3_["opts"]
local utils = require("eyeliner.utils")
local prev_y = 0
local function handle_hover()
  if not vim.b[vim.api.nvim_get_current_buf()].eyelinerDisabled then
    local line = utils["get-current-line"]()
    local _let_4_ = utils["get-cursor"]()
    local y = _let_4_[1]
    local x = _let_4_[2]
    local left = get_locations(line, x, "left")
    local right = get_locations(line, x, "right")
    clear_eyeliner(prev_y)
    apply_eyeliner(y, left)
    apply_eyeliner(y, right)
    prev_y = y
    return nil
  else
    return nil
  end
end
local function enable()
  if opts.debug then
    vim.notify("Always-on mode enabled")
  else
  end
  local _7_
  if utils["empty?"](opts.disabled_filetypes) then
    _7_ = "\\%<0"
  else
    _7_ = opts.disabled_filetypes
  end
  local function _9_()
    vim.b.eyelinerDisabled = true
    return nil
  end
  utils["set-autocmd"]({"FileType"}, {pattern = _7_, callback = _9_, group = "Eyeliner"})
  utils["set-autocmd"]({"CursorMoved", "WinScrolled", "BufReadPost"}, {callback = handle_hover, group = "Eyeliner"})
  local function _10_()
    return clear_eyeliner(prev_y)
  end
  return utils["set-autocmd"]({"InsertEnter", "BufLeave"}, {callback = _10_, group = "Eyeliner"})
end
return {enable = enable}
