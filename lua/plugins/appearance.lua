
-- appearance ------------------------------------------------------------------

--[[
  control how nvim looks: colors, icons, textures, menus, etc; distinct from
  interface in that interface elements should be functional (and ideally
  useful); appearance is the place for things that provide aesthetic value only
--]]

local LspKind     = require 'plugins.config.appearance.lspkind'
local TokyoNight  = require 'plugins.config.appearance.tokyonight'
local ColorScheme = require 'utils.plugins.colorscheme'
local Priority    = require 'utils.plugins.priority'

local Plugins = require('utils.plugins.plugin').plugins


return Plugins({
  ---- buf-resize: intuitively resize buffers when terminal dimensions change
  {
    'kwkarlwang/bufresize.nvim',
    opts = {},

    config = function(_, opts)
      require('bufresize').setup(opts)
    end
  },
  ---- colorschemes: using a strongly typed wrapper to enforce consisten colorscheme
  ----               plugin attributes
  ColorScheme('catppuccin/nvim'),
  ColorScheme('rebelot/kanagawa.nvim'),
  ColorScheme('marko-cerovac/material.nvim'),
  ColorScheme('AlexvZyl/nordic.nvim'),
  ColorScheme('folke/tokyonight.nvim')
    :configure('tokyonight', TokyoNight.opts()),
  ---- dressing.nvim: ui/ux treatments for vim input/select
  {
    'stevearc/dressing.nvim',

    config = function()
      require('dressing').setup()
    end
  },
  ---- lspkind: icons for lsp completion items
  {
    'onsails/lspkind.nvim',
    opts = LspKind.opts(),

    config = function(_, opts)
      require('lspkind').init(opts)
    end
  },
  ---- nui: ui components
  {
    'MunifTanjim/nui.nvim',

    lazy = false,
    -- we load this first since we want nvim-notify as early as possible; this comes before
    -- nvim-notify since this is a dependency of the latter
    priority = Priority.FIRST,
  },
})

