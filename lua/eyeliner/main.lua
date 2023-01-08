local shared = require("eyeliner.shared")
local always_on = require("eyeliner.always-on")
local on_key = require("eyeliner.on-key")
local utils = require("eyeliner.utils")
local _local_1_ = require("eyeliner.config")
local opts = _local_1_["opts"]
local enabled = false
local function enable()
  if not enabled then
    utils["create-augroup"]("Eyeliner", {})
    shared["enable-highlights"]()
    if opts.highlight_on_key then
      on_key.enable()
    else
      always_on.enable()
    end
    if opts.debug then
      vim.notify("Enabled eyeliner.nvim")
    else
    end
    enabled = true
    return true
  else
    return false
  end
end
local function disable()
  if enabled then
    utils["del-augroup"]("Eyeliner")
    if opts.highlight_on_key then
      on_key["remove-keybinds"]()
    else
    end
    if opts.debug then
      vim.notify("Disabled eyeliner.nvim")
    else
    end
    enabled = false
    return true
  else
    return false
  end
end
local function toggle()
  if enabled then
    return enable()
  else
    return disable()
  end
end
return {enable = enable, disable = disable, toggle = toggle}
