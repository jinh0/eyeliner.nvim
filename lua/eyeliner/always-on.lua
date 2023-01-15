local _local_1_ = require("eyeliner.liner")
local get_locations = _local_1_["get-locations"]
local _local_2_ = require("eyeliner.shared")
local apply_eyeliner = _local_2_["apply-eyeliner"]
local clear_eyeliner = _local_2_["clear-eyeliner"]
local _local_3_ = require("eyeliner.config")
local opts = _local_3_["opts"]
local utils = require("eyeliner.utils")
local _local_4_ = utils
local iter = _local_4_["iter"]
local prev_y = 0
local function handle_hover()
  local line = utils["get-current-line"]()
  local _let_5_ = utils["get-cursor"]()
  local y = _let_5_[1]
  local x = _let_5_[2]
  local left = get_locations(line, x, "left")
  local right = get_locations(line, x, "right")
  clear_eyeliner(prev_y)
  apply_eyeliner(y, left)
  apply_eyeliner(y, right)
  prev_y = y
  return nil
end
local function enable()
  if opts.debug then
    vim.notify("Always-on mode enabled")
  else
  end
  utils["set-autocmd"]({"CursorMoved", "WinScrolled", "BufReadPost"}, {callback = handle_hover, group = "Eyeliner"})
  local function _7_()
    return clear_eyeliner(prev_y)
  end
  return utils["set-autocmd"]({"InsertEnter"}, {callback = _7_, group = "Eyeliner"})
end
return {enable = enable}
