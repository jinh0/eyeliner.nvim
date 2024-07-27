local _local_1_ = require("eyeliner.config")
local opts = _local_1_["opts"]
local utils = require("eyeliner.utils")
local ns_id = vim.api.nvim_create_namespace("eyeliner")
local function enable_highlights()
  local primary = utils["get-hl"]("Constant")
  local secondary = utils["get-hl"]("Define")
  local dimmed = utils["get-hl"]("Comment")
  utils["set-hl"]("EyelinerPrimary", primary.foreground)
  utils["set-hl"]("EyelinerSecondary", secondary.foreground)
  utils["set-hl"]("EyelinerDimmed", dimmed.foreground)
  utils["create-augroup"]("Eyeliner", {clear = true})
  return utils["set-autocmd"]("ColorScheme", {callback = enable_highlights, group = "Eyeliner"})
end
local function apply_eyeliner(y, tokens)
  local function apply(token)
    local _let_2_ = token
    local x = _let_2_["x"]
    local freq = _let_2_["freq"]
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
    start = math.max(0, (x - opts.max_length))
  end
  local _end
  if (dir == "right") then
    _end = math.min(#line, (start + opts.max_length))
  else
    _end = x
  end
  return vim.api.nvim_buf_add_highlight(0, ns_id, "EyelinerDimmed", (y - 1), start, _end)
end
return {["enable-highlights"] = enable_highlights, ["apply-eyeliner"] = apply_eyeliner, ["clear-eyeliner"] = clear_eyeliner, dim = dim, ["ns-id"] = ns_id}
