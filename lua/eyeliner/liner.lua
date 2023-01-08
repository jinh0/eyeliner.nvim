local _local_1_ = require("eyeliner.string")
local str__3elist = _local_1_["str->list"]
local alphanumeric_3f = _local_1_["alphanumeric?"]
local alphabetic_3f = _local_1_["alphabetic?"]
local _local_2_ = require("eyeliner.utils")
local map = _local_2_["map"]
local filter = _local_2_["filter"]
local some_3f = _local_2_["some?"]
local function get_tokens(line, x, dir)
  local go_right_3f = (dir == "right")
  local function get_first_proper()
    local idx = (x + 1)
    while true do
      local function _3_()
        if go_right_3f then
          return (idx <= #line)
        else
          return (idx >= 1)
        end
      end
      if not (alphanumeric_3f(line:sub(idx, idx)) and _3_()) then break end
      local function _4_()
        if go_right_3f then
          return 1
        else
          return -1
        end
      end
      idx = (idx + _4_())
    end
    return idx
  end
  local freqs = {}
  local tokens = {}
  local line0 = str__3elist(line)
  local first_proper = get_first_proper()
  local start
  if go_right_3f then
    start = (x + 2)
  else
    start = 1
  end
  local _end
  if go_right_3f then
    _end = #line0
  else
    _end = x
  end
  for idx = start, _end do
    local char = (line0)[idx]
    local freq = freqs[char]
    if (freq == nil) then
      freqs[char] = 1
    else
      freqs[char] = (1 + freq)
    end
    table.insert(tokens, {x = idx, freq = freqs[char], char = char})
  end
  local function _8_(token)
    _G.assert((nil ~= token), "Missing argument token on fnl/eyeliner/liner.fnl:44")
    if go_right_3f then
      return (token.x >= first_proper)
    else
      return (token.x <= first_proper)
    end
  end
  return filter(_8_, tokens)
end
local function tokens__3ewords(tokens)
  local words = {}
  local not_empty_3f
  local function _10_(word)
    _G.assert((nil ~= word), "Missing argument word on fnl/eyeliner/liner.fnl:54")
    return (#word ~= 0)
  end
  not_empty_3f = _10_
  local word = {}
  for idx, token in ipairs(tokens) do
    if not alphanumeric_3f(token.char) then
      table.insert(words, word)
      word = {}
    else
      table.insert(word, token)
    end
  end
  table.insert(words, word)
  return filter(not_empty_3f, words)
end
local function get_locations(line, x, dir)
  local function min_token(word)
    local valid_tokens
    local function _12_(token)
      _G.assert((nil ~= token), "Missing argument token on fnl/eyeliner/liner.fnl:69")
      return alphabetic_3f(token.char)
    end
    valid_tokens = filter(_12_, word)
    local min = {freq = 9999999}
    for _, token in ipairs(valid_tokens) do
      if (token.freq < min.freq) then
        min = token
      else
        min = min
      end
    end
    return min
  end
  local tokens = get_tokens(line, x, dir)
  local words = tokens__3ewords(tokens)
  local min_tokens = map(min_token, words)
  local valid_3f
  local function _14_(token)
    _G.assert((nil ~= token), "Missing argument token on fnl/eyeliner/liner.fnl:78")
    return (token.freq <= 2)
  end
  valid_3f = _14_
  return filter(valid_3f, min_tokens)
end
return {["get-locations"] = get_locations}
