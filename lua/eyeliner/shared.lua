local utils = require("eyeliner.utils")
local ns_id = vim.api.nvim_create_namespace("eyeliner")
local function enable_highlights()
  local primary = utils["get-hl"]("Constant")
  local secondary = utils["get-hl"]("Define")
  utils["set-hl"]("EyelinerPrimary", primary.foreground)
  utils["set-hl"]("EyelinerSecondary", secondary.foreground)
  return utils["set-autocmd"]("ColorScheme", {callback = enable_highlights, group = "Eyeliner"})
end
local function apply_eyeliner(y, _1_)
  local _arg_2_ = _1_
  local x = _arg_2_["x"]
  local freq = _arg_2_["freq"]
  local hl_group
  if (freq == 1) then
    hl_group = "EyelinerPrimary"
  else
    hl_group = "EyelinerSecondary"
  end
  return vim.api.nvim_buf_add_highlight(0, ns_id, hl_group, (y - 1), (x - 1), x)
end
local function clear_eyeliner(y)
  if (y <= 0) then
    return vim.api.nvim_buf_clear_namespace(0, ns_id, 0, (y + 1))
  else
    return vim.api.nvim_buf_clear_namespace(0, ns_id, (y - 1), y)
  end
end
return {["enable-highlights"] = enable_highlights, ["apply-eyeliner"] = apply_eyeliner, ["clear-eyeliner"] = clear_eyeliner}
