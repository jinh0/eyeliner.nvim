local liner = require("eyeliner.liner")
local utils = require("eyeliner.utils")
local _local_1_ = require("eyeliner.shared")
local apply_eyeliner = _local_1_["apply-eyeliner"]
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
  local line = utils["get-current-line"]()
  local _let_2_ = utils["get-cursor"]()
  local y = _let_2_[1]
  local x = _let_2_[2]
  local to_apply = traverse(line, x)
  apply_eyeliner(to_apply)
  return nil
end
local function enable()
  return utils["set-autocmd"]({"CursorMoved", "WinScrolled", "BufReadPost"}, {callback = handle_hover, group = "Eyeliner"})
end
return {enable = enable}
