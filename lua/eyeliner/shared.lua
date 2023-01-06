local utils = require("eyeliner.utils")
local function enable_highlights()
  local primary = utils["get-hl"]("Constant")
  local secondary = utils["get-hl"]("Define")
  utils["set-hl"]("EyelinerPrimary", primary.foreground)
  utils["set-hl"]("EyelinerSecondary", secondary.foreground)
  return utils["set-autocmd"]("ColorScheme", {callback = enable_highlights, group = "Eyeliner"})
end
local function apply_eyeliner(locations)
  return nil
end
local function clear_eyeliner()
  return vim.notify("todo: clear-eyeliner")
end
return {["enable-highlights"] = enable_highlights, ["apply-eyeliner"] = apply_eyeliner, ["clear-eyeliner"] = clear_eyeliner}
