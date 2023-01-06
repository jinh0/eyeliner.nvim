local function str__3elist(str)
  local tbl = {}
  for i = 1, #str do
    table.insert(tbl, str:sub(i, i))
  end
  return tbl
end
local dividers = {["("] = true, [")"] = true, ["["] = true, ["]"] = true, ["{"] = true, ["}"] = true, [":"] = true, ["."] = true, [","] = true, ["?"] = true, ["!"] = true, [";"] = true, ["-"] = true, _ = true, ["|"] = true, [" "] = true, ["#"] = true}
local function divider_3f(char)
  return (dividers[char] == true)
end
return {["str->list"] = str__3elist, ["divider?"] = divider_3f}
