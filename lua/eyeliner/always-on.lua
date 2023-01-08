local _local_1_ = require("eyeliner.liner")
local get_locations = _local_1_["get-locations"]
local _local_2_ = require("eyeliner.shared")
local apply_eyeliner = _local_2_["apply-eyeliner"]
local clear_eyeliner = _local_2_["clear-eyeliner"]
local utils = require("eyeliner.utils")
local _local_3_ = utils
local iter = _local_3_["iter"]
local prev_y = 0
local function handle_hover()
  local line = utils["get-current-line"]()
  local _let_4_ = utils["get-cursor"]()
  local y = _let_4_[1]
  local x = _let_4_[2]
  local to_apply_left = get_locations(line, x, "left")
  local to_apply_right = get_locations(line, x, "right")
  clear_eyeliner(prev_y)
  local function _5_(token)
    _G.assert((nil ~= token), "Missing argument token on fnl/eyeliner/always-on.fnl:21")
    return apply_eyeliner(token.x, y, token.freq)
  end
  iter(_5_, to_apply_left)
  local function _6_(token)
    _G.assert((nil ~= token), "Missing argument token on fnl/eyeliner/always-on.fnl:22")
    return apply_eyeliner(token.x, y, token.freq)
  end
  iter(_6_, to_apply_right)
  prev_y = y
  return nil
end
local function enable()
  utils["set-autocmd"]({"CursorMoved", "WinScrolled", "BufReadPost"}, {callback = handle_hover, group = "Eyeliner"})
  local function _7_()
    return clear_eyeliner(prev_y)
  end
  return utils["set-autocmd"]({"InsertEnter"}, {callback = _7_, group = "Eyeliner"})
end
return {enable = enable}
