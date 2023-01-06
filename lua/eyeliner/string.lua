local function str__3elist(str)
  local tbl = {}
  for i = 1, #str do
    table.insert(tbl, str:sub(i, i))
  end
  return tbl
end
local function alphanumeric_3f(char)
  return char:match("%w")
end
local function alphabetic_3f(char)
  return char:match("[A-Za-z]")
end
return {["str->list"] = str__3elist, ["alphanumeric?"] = alphanumeric_3f, ["alphabetic?"] = alphabetic_3f}
