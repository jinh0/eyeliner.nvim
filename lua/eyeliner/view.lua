local utils = require('eyeliner.utils')
local config = require('eyeliner.config')

-- Test string:
-- ccc.bba.baa.test.typing.last
--   x  ;  x    ^    x     x
--
-- ^ = user's cursor
-- x = primary highlight
-- ; = secondary highlight

local M = {}
M.enabled = false

local prev_y, y = 0, 0
local ns_id = vim.api.nvim_create_namespace('eyeliner')

function M.set_hl_colors()
  local primary_color = vim.api.nvim_get_hl_by_name('Constant', true)
  local secondary_color = vim.api.nvim_get_hl_by_name('Define', true)

  vim.api.nvim_set_hl(0, 'EyelinerPrimary', { fg = primary_color.foreground, default = true })
  vim.api.nvim_set_hl(0, 'EyelinerSecondary', { fg = secondary_color.foreground, default = true })
end

function M.enable()
  if M.enabled then return end

  -- Set highlight colors
  M.set_hl_colors()

  local group_id = vim.api.nvim_create_augroup('Eyeliner', {})
  vim.api.nvim_create_autocmd('ColorScheme', {
    group = group_id,
    callback = function()
      return require('eyeliner.view').set_hl_colors()
    end
  })

  -- Enable different modes
  if config.opts.highlight_on_key then
    for _, key in ipairs({'f', 'F', 't', 'T'}) do
      vim.keymap.set({'n', 'v'}, key, function()
        local line = vim.api.nvim_get_current_line()
        local cursor = vim.api.nvim_win_get_cursor(0)

        y = cursor[1]
        local x = cursor[2]

        if key == 'f' or key == 't' then
          M.traverse_one(line, cursor[2], 1)
        else
          M.traverse_one(line, cursor[2], -1)
        end

        -- Draw fake cursor, since getcharstr() will move the real cursor
        -- down in the command line
        vim.api.nvim_buf_add_highlight(0, ns_id, 'Cursor', cursor[1] - 1, cursor[2], cursor[2] + 1)

        -- :redraw necessary to show new highlights
        vim.cmd([[ :redraw ]])

        -- Get user's character, but use pcall() since
        -- the user may throw a <c-c> which will cause an
        -- error with getcharstr()
        pcall(function()
          local char = vim.fn.getcharstr()

          -- Default behavior
          vim.api.nvim_feedkeys(key, 'n', true)
          vim.api.nvim_feedkeys(char, 'n', true)
        end)

        return require('eyeliner.view').clear_cursor_highlight()
      end)
    end
  else
    vim.api.nvim_create_autocmd({'BufReadPost', 'CursorMoved', 'WinScrolled'}, {
      group = group_id,
      callback = function()
        return require('eyeliner.view').handle_hover()
      end
    })
  end

  M.enabled = true
end

function M.disable()
  if not M.enabled then return end

  if config.opts.highlight_on_key then
    for _, key in ipairs({'f', 'F', 't', 'T'}) do
      vim.keymap.del({'n', 'v'}, key)
    end
  else
    M.clear_prev_highlight()
  end

  vim.api.nvim_del_augroup_by_name('Eyeliner')

  M.enabled = false
end

function M.toggle()
  if M.enabled then
    M.disable()
  else
    M.enable()
  end
end

function M.handle_hover()
  local line = vim.api.nvim_get_current_line()
  local cursor = vim.api.nvim_win_get_cursor(0)

  y = cursor[1]
  local x = cursor[2]

  M.clear_prev_highlight()
  M.traverse(line, x)
end

function M.clear_cursor_highlight()
  local cursor = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_buf_clear_namespace(0, ns_id, cursor[1] - 1, cursor[1] + 1)
end

function M.clear_prev_highlight()
  if (prev_y == 0) then
    vim.api.nvim_buf_clear_namespace(0, ns_id, 0, prev_y + 1)
  else
    vim.api.nvim_buf_clear_namespace(0, ns_id, prev_y - 1, prev_y)
  end
  prev_y = y
end

--- Set highlight at position
--- @param x number
function M.highlight_x(x, is_prim)
  if is_prim then
    vim.api.nvim_buf_add_highlight(0, ns_id, 'EyelinerPrimary', y - 1, x - 1, x)
  else
    vim.api.nvim_buf_add_highlight(0, ns_id, 'EyelinerSecondary', y - 1, x - 1, x)
  end
end

--- Find and set highlight in word
--- @param chars table
function M.find_hil(chars)
  local minKey, minVal = nil, math.huge

  for key, value in pairs(chars) do
    -- prefer lowest key/index
    if value < minVal or (value == minVal and key < minKey) then
      minKey, minVal = key, value
    end
  end

  if not (minKey == nil) and minVal <= 2 then
    M.highlight_x(minKey, minVal == 1)
  end

end
--- traverse in one direction
--- @param str string
--- @param x number
--- @param dir number (1 = right, -1 = left)
--- {{{
function M.traverse_one(str, x, dir)
  local start = x
  local stop = (dir == 1) and #str or 1

  local freq = {}

  -- calculate frequency for the current/hovered word and jump
  -- to the next word; there is no highlighting for the hovered word
  for i = start, stop, dir do
    local c = str:sub(i, i)
    if not utils.is_alpha(c) then
      start = i + dir
      break
    end

    if i == stop then
      return {}
    end

    if freq[c] == nil then
      freq[c] = 1
    else
      freq[c] = freq[c] + 1
    end
  end

  local highlighted = false
  local chars = {}
  for i = start, stop, dir do
    local c = str:sub(i, i)

    if not utils.is_alpha(c) then
      -- if not highlighted having reached the end of the word,
      -- pick the index of minimum frequency for highlighting
      if not highlighted then
        M.find_hil(chars)
      end

      chars = {}
      highlighted = false
    else
      if freq[c] == nil then
        -- greedily highlight the first instance of a never-before-seen
        -- character (freq[c] == nil) ONLY if it's not been highlighted yet
        -- and direction is to the right (when going left, it is not greedy)
        if not highlighted and dir == 1 then
          M.highlight_x(i, true)
          highlighted = true
        end
        freq[c] = 1
        chars[i] = 1
      else
        freq[c] = freq[c] + 1
        chars[i] = freq[c]
      end
    end
  end

  if not highlighted then
    M.find_hil(chars)
  end
end
-- }}}

--- traverse the line in both directions
--- @param line string
--- @param x number
function M.traverse(line, x)
  M.traverse_one(line, x, -1)
  M.traverse_one(line, x, 1)
end

return M
