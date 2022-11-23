local opts = {debug = false, highlight_on_key = false}
local function setup(user)
  local merged = vim.tbl_deep_extend("force", {}, opts, (user or {}))
  opts = merged
  if (opts == true) then
    return vim.notify(vim.inspect(opts))
  else
    return nil
  end
end
return {setup = setup, opts = opts}
