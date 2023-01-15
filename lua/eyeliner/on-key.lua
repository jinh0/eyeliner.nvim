local _local_1_ = require("eyeliner.liner")
local get_locations = _local_1_["get-locations"]
local _local_2_ = require("eyeliner.config")
local opts = _local_2_["opts"]
local _local_3_ = require("eyeliner.shared")
local ns_id = _local_3_["ns-id"]
local clear_eyeliner = _local_3_["clear-eyeliner"]
local apply_eyeliner = _local_3_["apply-eyeliner"]
local dim = _local_3_["dim"]
local utils = require("eyeliner.utils")
local _local_4_ = utils
local iter = _local_4_["iter"]
local function handle_keypress(key, operator)
  local function simulate_find()
    local char = vim.fn.getcharstr()
    if operator then
      vim.api.nvim_feedkeys(operator, "n", true)
    else
    end
    vim.api.nvim_feedkeys(key, "n", true)
    return vim.api.nvim_feedkeys(char, "n", true)
  end
  local function on_key()
    local line = utils["get-current-line"]()
    local _let_6_ = utils["get-cursor"]()
    local y = _let_6_[1]
    local x = _let_6_[2]
    local dir
    if ((key == "f") or (key == "t")) then
      dir = "right"
    else
      dir = "left"
    end
    local to_apply = get_locations(line, x, dir)
    if opts.dim then
      dim(y, x, dir)
    else
    end
    apply_eyeliner(y, to_apply)
    utils["add-hl"](ns_id, "Cursor", x)
    vim.cmd(":redraw")
    pcall(simulate_find)
    return clear_eyeliner(y)
  end
  return on_key
end
local function enable()
  if opts.debug then
    vim.notify("On-keypress mode enabled")
  else
  end
  for _, key in ipairs({"f", "F", "t", "T"}) do
    vim.keymap.set({"n", "x"}, key, handle_keypress(key))
    for _0, operator in ipairs({"d", "y"}) do
      vim.keymap.set({"n"}, (operator .. key), handle_keypress(key, operator))
    end
  end
  return nil
end
local function remove_keybinds()
  for _, key in ipairs({"f", "F", "t", "T"}) do
    vim.keymap.del({"n", "x"}, key)
    for _0, operator in ipairs({"d", "y"}) do
      vim.keymap.del({"n"}, (operator .. key))
    end
  end
  return nil
end
return {enable = enable, ["remove-keybinds"] = remove_keybinds, handle_keypress = handle_keypress}
