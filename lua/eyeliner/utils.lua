local M = {}

local alphas = {
  a = true, b = true, c = true, d = true, e = true, f = true, g = true,
  h = true, i = true, j = true, k = true, l = true, m = true, n = true,
  o = true, p = true, q = true, r = true, s = true, t = true, u = true,
  v = true, w = true, x = true, y = true, z = true,
  A = true, B = true, C = true, D = true, E = true, F = true, G = true,
  H = true, I = true, J = true, K = true, L = true, M = true, N = true,
  O = true, P = true, Q = true, R = true, S = true, T = true, U = true,
  V = true, W = true, X = true, Y = true, Z = true,
}

--- check if char is an alphabetical character
--- @param c string
--- @return boolean
function M.is_alpha(c)
  return alphas[c]
end

return M
