local _local_1_ = require("eyeliner.config")
local opts = _local_1_["opts"]
local utils = require("eyeliner.utils")
local ns_id = vim.api.nvim_create_namespace("eyeliner")
local function enable_highlights()
  local callback
  local function _2_()
    local primary = utils["get-hl"]("Constant")
    local secondary = utils["get-hl"]("Define")
    local dimmed = utils["get-hl"]("Comment")
    utils["set-hl"]("EyelinerPrimary", primary.foreground)
    utils["set-hl"]("EyelinerSecondary", secondary.foreground)
    return utils["set-hl"]("EyelinerDimmed", dimmed.foreground)
  end
  callback = _2_
  callback()
  return utils["set-autocmd"]("ColorScheme", {callback = callback, group = "Eyeliner"})
end
local function apply_eyeliner(y, tokens)
  local function apply(token)
    local _let_3_ = token
    local x = _let_3_["x"]
    local freq = _let_3_["freq"]
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
local function disable_filetypes()
  local _8_
  if utils["empty?"](opts.disabled_filetypes) then
    _8_ = "\\%<0"
  else
    _8_ = opts.disabled_filetypes
  end
  local function _10_()
    vim.b.eyelinerDisabled = true
    return nil
  end
  return utils["set-autocmd"]({"FileType"}, {pattern = _8_, callback = _10_})
end
local function disable_buftypes()
  local function _11_()
    local bufnr = vim.api.nvim_get_current_buf()
    local _let_12_ = vim.bo[bufnr]
    local buftype = _let_12_["buftype"]
    if utils["exists?"](opts.disabled_buftypes, buftype) then
      vim.b.eyelinerDisabled = true
      return nil
    else
      return nil
    end
  end
  return utils["set-autocmd"]({"BufEnter", "BufWinEnter"}, {callback = _11_})
end
return {["enable-highlights"] = enable_highlights, ["apply-eyeliner"] = apply_eyeliner, ["clear-eyeliner"] = clear_eyeliner, ["disable-filetypes"] = disable_filetypes, ["disable-buftypes"] = disable_buftypes, dim = dim, ["ns-id"] = ns_id}
