local M = {}

local defaults = {
  primary_color = nil,
  secondary_color = nil,
  underlined = false,
  bold = false,
}

M.setup = function(opt)
  M.opts = vim.tbl_deep_extend('force', {}, defaults, opt or {})
end

return M
