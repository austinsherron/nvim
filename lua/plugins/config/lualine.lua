local navic = require 'nvim-navic'


local function get_location()
  return navic.get_location()
end


local function is_available()
  return navic.is_available()
end

--- Contains functions for configuring the lualine plugin.
---
---@class Lualine
local Lualine = {}

---@return table: a table that contains configuration values for the lualine plugin
function Lualine.opts()
  return {
    extensions = { 'aerial', 'nvim-tree' },
    sections = {
      lualine_b = { { 'filename', path = 1 } },
      lualine_c = { 'searchcount', 'selectioncount' },
      lualine_x = { 'diff', 'branch' },
    },
    winbar = {
      lualine_a = { { 'tabs', mode = 0, use_mode_colors = true } },
      lualine_b = { 'filetype', 'fileformat', 'encoding' },
      lualine_c = {
        'diagnostics',
        { get_location, cond = is_available, draw_empty = true },
      },
    },
    inactive_winbar = {
      lualine_a = { { 'tabs', mode = 0, use_mode_colors = true } },
      lualine_b = { 'filetype', 'fileformat', 'encoding' },
    },
  }
end

return Lualine

