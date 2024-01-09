local Custom = require 'plugins.extensions.interface.lualine'

-- TODO: trying out lspsaga's winbar; remove if I decide to stick w/ that
-- local navic = require 'nvim-navic'

local function is_code_context_available()
  return require 'lspsaga.symbol.winbar' ~= nil
end

local function get_code_context()
  return require('lspsaga.symbol.winbar').get_bar()
end

--- Contains functions for configuring the lualine plugin.
---
---@class Lualine
local Lualine = {}

---@return table: a table that contains configuration values for the lualine plugin
function Lualine.opts()
  return {
    extensions = { 'aerial', 'nvim-tree' },
    winbar = {
      lualine_a = { {
        'tabs',
        mode = 0,
        use_mode_colors = true,
      } },
      lualine_b = {
        'filetype',
        'fileformat',
        'encoding',
        Custom.project_context(),
        'diagnostics',
      },
      lualine_c = {
        {
          get_code_context,
          cond = is_code_context_available,
          draw_empty = false,
        },
      },
    },
    sections = {
      lualine_b = { { 'filename', path = 1 } },
      lualine_c = { 'searchcount', 'selectioncount' },
      lualine_x = { 'diff', 'branch' },
    },
    inactive_winbar = {
      lualine_a = { { 'tabs', mode = 0, use_mode_colors = true } },
      lualine_b = { 'filetype', 'fileformat', 'encoding' },
    },
  }
end

return Lualine
