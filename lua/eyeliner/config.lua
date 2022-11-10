local opts = {debug = false, highlight_on_key = false}
local function setup(user)
  local merged = vim.tbl_deep_extend("force", {}, opts, (user or {}))
  if (merged.debug == true) then
    vim.notify(vim.inspect(merged))
  else
  end
  opts = merged
  return nil
end
return {setup = setup, opts = defaults}
