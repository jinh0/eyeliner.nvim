local _local_1_ = require("eyeliner.liner")
local get_locations = _local_1_["get-locations"]
local _local_2_ = require("eyeliner.shared")
local apply_eyeliner = _local_2_["apply-eyeliner"]
local clear_eyeliner = _local_2_["clear-eyeliner"]
local disable_filetypes = _local_2_["disable-filetypes"]
local disable_buftypes = _local_2_["disable-buftypes"]
local _local_3_ = require("eyeliner.config")
local opts = _local_3_["opts"]
local utils = require("eyeliner.utils")
local prev_y = 0
local function handle_hover()
  if not vim.b[vim.api.nvim_get_current_buf()].eyelinerDisabled then
    local line = utils["get-current-line"]()
    local _let_4_ = utils["get-cursor"]()
    local y = _let_4_[1]
    local x = _let_4_[2]
    local left = get_locations(line, x, "left")
    local right = get_locations(line, x, "right")
    clear_eyeliner(prev_y)
    apply_eyeliner(y, left)
    apply_eyeliner(y, right)
    prev_y = y
    return nil
  else
    return nil
  end
end
local function enable()
  if opts.debug then
    vim.notify("Always-on mode enabled")
  else
  end
  disable_filetypes()
  disable_buftypes()
  utils["set-autocmd"]({"CursorMoved", "WinScrolled", "BufReadPost"}, {callback = handle_hover, group = "Eyeliner"})
  local function _7_()
    return clear_eyeliner(prev_y)
  end
  return utils["set-autocmd"]({"InsertEnter", "BufLeave", "BufWinLeave"}, {callback = _7_, group = "Eyeliner"})
end
return {enable = enable}
