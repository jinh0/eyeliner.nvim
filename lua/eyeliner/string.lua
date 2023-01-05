local function str__3elist(str)
  local tbl = {}
  for i = 1, #str do
    table.insert(tbl, str:sub(i, i))
  end
  return tbl
end
return {["str->list"] = str__3elist}
