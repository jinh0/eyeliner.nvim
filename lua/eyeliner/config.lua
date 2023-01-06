local opts = {highlight_on_key = false, debug = false}
local function setup(user)
  local merged = vim.tbl_deep_extend("force", {}, opts, (user or {}))
  opts.highlight_on_key = merged.highlight_on_key
  opts.debug = merged.debug
  return nil
end
return {setup = setup, opts = opts}
