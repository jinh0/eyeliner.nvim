local _local_1_ = require("eyeliner.string")
local str__3elist = _local_1_["str->list"]
local function get_scores(line, x)
  local freqs = {}
  local scores = {}
  local line0 = str__3elist(line)
  for i = (x + 1), #line0 do
    local char = (line0)[i]
    if (freqs[char] == nil) then
      freqs[char] = 1
    else
      freqs[char] = (1 + freqs[char])
    end
    table.insert(scores, {x = i, score = freqs[char], char = char})
  end
  return scores
end
return {["get-scores"] = get_scores}
