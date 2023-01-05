local function str__3elist(str)
  local tbl = {}
  for i = 1, #str do
    table.insert(tbl, str:sub(i, i))
  end
  return tbl
end
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
    table.insert(scores, {x = i, s = freqs[char], c = char})
  end
  return scores
end
return {["str->list"] = str__3elist, ["get-scores"] = get_scores}
