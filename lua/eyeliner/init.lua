local config = require("eyeliner.config")
local main = require("eyeliner.main")
local _local_1_ = require("eyeliner.on-key")
local highlight = _local_1_["highlight"]
return {setup = config.setup, enable = main.enable, disable = main.disable, toggle = main.toggle, highlight = highlight}
