local utils = require("eyeliner.utils")
local ns_id = vim.api.nvim_create_namespace("eyeliner")
local function enable_highlights()
  vim.api.nvim_set_hl(0, "EyelinerPrimary", {link = "Constant"})
  vim.api.nvim_set_hl(0, "EyelinerSecondary", {link = "Define"})
  vim.api.nvim_set_hl(0, "EyelinerDimmed", {link = "Comment"})
  return utils["set-autocmd"]("ColorScheme", {callback = enable_highlights, group = "Eyeliner"})
end
local function apply_eyeliner(y, tokens)
  local function apply(token)
    local _let_1_ = token
    local x = _let_1_["x"]
    local freq = _let_1_["freq"]
    local hl_group
    if (freq == 1) then
      hl_group = "EyelinerPrimary"
    else
      hl_group = "EyelinerSecondary"
    end
    return vim.api.nvim_buf_add_highlight(0, ns_id, hl_group, (y - 1), (x - 1), x)
  end
  return utils.iter(apply, tokens)
end
local function clear_eyeliner(y)
  if (y <= 0) then
    return vim.api.nvim_buf_clear_namespace(0, ns_id, 0, (y + 1))
  else
    return vim.api.nvim_buf_clear_namespace(0, ns_id, (y - 1), y)
  end
end
local function dim(y, x, dir)
  local line = utils["get-current-line"]()
  local start
  if (dir == "right") then
    start = (x + 1)
  else
    start = 0
  end
  local _end
  if (dir == "right") then
    _end = #line
  else
    _end = x
  end
  return vim.api.nvim_buf_add_highlight(0, ns_id, "EyelinerDimmed", (y - 1), start, _end)
end
return {["enable-highlights"] = enable_highlights, ["apply-eyeliner"] = apply_eyeliner, ["clear-eyeliner"] = clear_eyeliner, dim = dim, ["ns-id"] = ns_id}
