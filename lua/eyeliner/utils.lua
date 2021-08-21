local M = {}

--[[
local delims = {
  ['.'] = true, [' '] = true,
  ['('] = true, [')'] = true,
  ['['] = true, [']'] = true,
  ['{'] = true, ['}'] = true,
  ['='] = true, [','] = true,
  [':'] = true, ['_'] = true,
  ['+'] = true, ['-'] = true,
  ['*'] = true, ['/'] = true,
  ["'"] = true, ['"'] = true,
  ["<"] = true, ['>'] = true,
  ["#"] = true
}
--]]

-- todo: capital letters
local alphas = {
  a = true, b = true, c = true, d = true, e = true, f = true, g = true,
  h = true, i = true, j = true, k = true, l = true, m = true, n = true,
  o = true, p = true, q = true, r = true, s = true, t = true, u = true,
  v = true, w = true, x = true, y = true, z = true,
}

--- check if char is an alphabetical character
--- @param c string
--- @return boolean
function M.is_alpha(c)
  return alphas[c]
end

--- @param hl_group string
--- @return string guifg
function M.get_syncolor(hl_group)
  return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(hl_group)), 'fg#')
end

return M
