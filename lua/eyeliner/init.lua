local function enable()
  return print("Enabled!")
end
local function disable()
  return print("Disabled!")
end
return {enable = enable}
