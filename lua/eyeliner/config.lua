local opts = {match = "[A-Za-z]", dim = false, highlight_on_key = false, debug = false}
local function setup(user)
  local _let_1_ = require("eyeliner.main")
  local enabled_3f = _let_1_["enabled?"]
  local enable = _let_1_["enable"]
  local disable = _let_1_["disable"]
  local merged = vim.tbl_deep_extend("force", {}, opts, (user or {}))
  if enabled_3f() then
    disable()
  else
  end
  for key, value in pairs(merged) do
    opts[key] = value
  end
  if opts.debug then
    vim.notify("Eyeliner debug mode enabled")
  else
  end
  return enable()
end
return {setup = setup, opts = opts}
