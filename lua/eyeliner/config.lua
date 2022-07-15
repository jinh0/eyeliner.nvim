local M = {}

local defaults = {
  highlight_on_key = true
}

M.opts = defaults

M.setup = function(opt)
  M.opts = vim.tbl_deep_extend('force', {}, defaults, opt or {})
end

return M
