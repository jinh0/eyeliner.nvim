-- Configuration
local M = {}

local defaults = {
  highlight_on_key = false,
  debug = false
}

M.opts = defaults

M.setup = function(opt)
  M.opts = vim.tbl_deep_extend('force', {}, defaults, opt or {})

  if M.opts.debug then
    vim.notify("DEBUG: " .. vim.inspect(M.opts))
  end
end

return M
