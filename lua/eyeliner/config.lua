local opts = {debug = false, highlight_on_key = false, dim = false}
local function setup(user)
  local _let_1_ = require("eyeliner.main")
  local enabled = _let_1_["enabled"]
  local enable = _let_1_["enable"]
  local disable = _let_1_["disable"]
  local merged = vim.tbl_deep_extend("force", {}, opts, (user or {}))
  if enabled then
    disable()
  else
  end
  opts.highlight_on_key = merged.highlight_on_key
  opts.dim = merged.dim
  opts.debug = merged.debug
  return enable()
end
return {setup = setup, opts = opts}
