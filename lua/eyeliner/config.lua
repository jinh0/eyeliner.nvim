local M = {}

local defaults = {
  primary_color = nil,
  secondary_color = nil,
  underline = false,
  bold = false,
  debug = false
}

M.opts = defaults

M.setup = function(opt)
  M.opts = vim.tbl_deep_extend('force', {}, defaults, opt or {})
end

return M
