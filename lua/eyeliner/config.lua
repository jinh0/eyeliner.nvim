local M = {}

local defaults = {}

M.opts = defaults

M.setup = function(opt)
  M.opts = vim.tbl_deep_extend('force', {}, defaults, opt or {})
end

return M
