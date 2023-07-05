local navic = require 'nvim-navic'


local function get_location()
  return navic.get_location()
end


local function is_available()
  return navic.is_available()
end

local Ll = {}

function Ll.opts()
  return {
    extensions = { 'aerial', 'nvim-tree' },
    sections = {
      lualine_b = { 'searchcount', 'selectioncount' },
      lualine_c = { { 'filename', path = 1 } },
      lualine_x = { 'diagnostics', 'diff', 'branch' },
    },
    winbar = {
      lualine_a = { { 'tabs', mode = 0, use_mode_colors = true } },
      lualine_b = { 'filetype', 'fileformat', 'encoding' },
      lualine_c = { { get_location, cond = is_available, draw_empty = true } },
    },
    inactive_winbar = {
      lualine_a = { { 'tabs', mode = 0, use_mode_colors = true } },
      lualine_b = { 'filetype', 'fileformat', 'encoding' },
    },
  }
end

return Ll

