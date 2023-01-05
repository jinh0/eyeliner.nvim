local shared = require("eyeliner.shared")
local always_on = require("eyeliner.always-on")
local on_key = require("eyeliner.on-key")
local utils = require("eyeliner.utils")
local enabled = false
local ns_id = vim.api.nvim_create_namespace("eyeliner")
local function enable()
  if not enabled then
    local opts = (require("eyeliner.config")).opts
    utils["create-augroup"]("Eyeliner", {})
    shared["enable-highlights"]()
    if opts["highlight-on-key"] then
      on_key.enable()
    else
      always_on.enable()
    end
    enabled = true
    return true
  else
    return false
  end
end
local function disable()
  if enabled then
    shared["remove-keybinds"]()
    shared["clear-eyeliner"]()
    utils["del-augroup"]("Eyeliner")
    enabled = false
    return nil
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
