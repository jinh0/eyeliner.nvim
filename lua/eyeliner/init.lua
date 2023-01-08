local config = require("eyeliner.config")
local main = require("eyeliner.main")
return {setup = config.setup, enable = main.enable, disable = main.disable, toggle = main.toggle}
