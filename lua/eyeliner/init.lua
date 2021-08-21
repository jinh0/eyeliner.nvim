local view = require('eyeliner.view')
local config = require('eyeliner.config')

local M = {}
M.setup = config.setup
M.enable = view.enable
M.disable = view.disable
M.toggle = view.toggle

return M
