local _local_1_ = require("eyeliner.string")
local str__3elist = _local_1_["str->list"]
local alphanumeric_3f = _local_1_["alphanumeric?"]
local alphabetic_3f = _local_1_["alphabetic?"]
local _local_2_ = require("eyeliner.utils")
local map = _local_2_["map"]
local filter = _local_2_["filter"]
local some_3f = _local_2_["some?"]
local _local_3_ = require("eyeliner.config")
local opts = _local_3_["opts"]
local function get_tokens(line, x, dir)
  local go_right_3f = (dir == "right")
  local step
  if go_right_3f then
    step = 1
  else
    step = -1
  end
  local function get_first_proper()
    local idx = (x + 1)
    while true do
      local function _5_()
        if go_right_3f then
          return (idx <= #line)
        else
          return (idx >= 1)
        end
      end
      if not (alphanumeric_3f(line:sub(idx, idx)) and _5_()) then break end
      idx = (idx + step)
    end
    return idx
  end
  local function reversed(list)
    local new_list = {}
    for idx = #list, 1, -1 do
      table.insert(new_list, list[idx])
    end
    return new_list
  end
  local freqs = {}
  local tokens = {}
  local line0 = str__3elist(line)
  local first_proper = get_first_proper()
  local start
  if go_right_3f then
    start = (x + 2)
  else
    start = x
  end
  local _end
  if go_right_3f then
    _end = #line0
  else
    _end = 1
  end
  for idx = start, _end, step do
    if not ((line0)[idx] == nil) then
      local char = (line0)[idx]
      local freq = freqs[char]
      if (freq == nil) then
        freqs[char] = 1
      else
        freqs[char] = (1 + freq)
      end
      table.insert(tokens, {x = idx, freq = freqs[char], char = char})
    else
    end
  end
  local function _10_(token)
    _G.assert((nil ~= token), "Missing argument token on fnl/eyeliner/liner.fnl:54")
    if go_right_3f then
      return (token.x >= first_proper)
    else
      return (token.x <= first_proper)
    end
  end
  local function _12_()
    if go_right_3f then
      return tokens
    else
      return reversed(tokens)
    end
  end
  return filter(_10_, _12_())
end
local function tokens__3ewords(tokens)
  local words = {}
  local not_empty_3f
  local function _13_(word)
    _G.assert((nil ~= word), "Missing argument word on fnl/eyeliner/liner.fnl:67")
    return (#word ~= 0)
  end
  not_empty_3f = _13_
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
    local function _15_(token)
      _G.assert((nil ~= token), "Missing argument token on fnl/eyeliner/liner.fnl:82")
      return (token.char):match(opts.match)
    end
    valid_tokens = filter(_15_, word)
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
  local function _17_(token)
    _G.assert((nil ~= token), "Missing argument token on fnl/eyeliner/liner.fnl:91")
    return (token.freq <= 2)
  end
  valid_3f = _17_
  return filter(valid_3f, min_tokens)
end
return {["get-locations"] = get_locations}
