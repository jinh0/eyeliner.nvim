local _local_1_ = require("eyeliner.string")
local str__3elist = _local_1_["str->list"]
local alphanumeric_3f = _local_1_["alphanumeric?"]
local alphabetic_3f = _local_1_["alphabetic?"]
local _local_2_ = require("eyeliner.utils")
local map = _local_2_["map"]
local filter = _local_2_["filter"]
local some_3f = _local_2_["some?"]
local function get_tokens(line, x)
  local function get_first_proper()
    local idx = (x + 1)
    while (alphanumeric_3f(line:sub(idx, idx)) and (idx <= #line)) do
      idx = (idx + 1)
    end
    return idx
  end
  local freqs = {}
  local tokens = {}
  local line0 = str__3elist(line)
  local first_proper = get_first_proper()
  for idx = first_proper, #line0 do
    local char = (line0)[idx]
    local freq = freqs[char]
    if (freq == nil) then
      freqs[char] = 1
    else
      freqs[char] = (1 + freq)
    end
    table.insert(tokens, {x = idx, freq = freqs[char], char = char})
  end
  return tokens
end
local function tokens__3ewords(tokens)
  local words = {}
  local not_empty_3f
  local function _4_(word)
    _G.assert((nil ~= word), "Missing argument word on fnl/eyeliner/liner.fnl:46")
    return (#word ~= 0)
  end
  not_empty_3f = _4_
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
local function get_locations(line, x)
  local function min_token(word)
    local valid_tokens
    local function _6_(token)
      _G.assert((nil ~= token), "Missing argument token on fnl/eyeliner/liner.fnl:61")
      return alphabetic_3f(token.char)
    end
    valid_tokens = filter(_6_, word)
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
  local tokens = get_tokens(line, x)
  local words = tokens__3ewords(tokens)
  local min_tokens = map(min_token, words)
  local valid_3f
  local function _8_(token)
    _G.assert((nil ~= token), "Missing argument token on fnl/eyeliner/liner.fnl:70")
    return (token.freq <= 2)
  end
  valid_3f = _8_
  return filter(valid_3f, min_tokens)
end
return {["get-locations"] = get_locations}
