local function enable()
  return vim.notify("todo")
end
local function remove_keybinds()
  local _let_1_ = require("eyeliner.config")
  local opts = _let_1_["opts"]
  if opts["highlight-on-key"] then
    return vim.notify("todo: remove-keybinds")
  else
    return nil
  end
end
return {enable = enable, ["remove-keybinds"] = remove_keybinds}
