
-- appearance ------------------------------------------------------------------

--[[
  control how nvim looks: colors, icons, textures, menus, etc; distinct from
  interface in that interface elements should be functional (and ideally
  useful); appearance is the place for things that provide aesthetic value only
--]]

local LspKind  = require 'plugins.config.appearance.lspkind'
local Plugins  = require('utils.plugins.plugin').plugins
local Priority = require 'utils.plugins.priority'


return Plugins({
  ---- buf-resize: intuitively resize buffers when terminal dimensions change
  ---- TODO: doesn't seem to work
  { 'kwkarlwang/bufresize.nvim' },
  ---- colorschemes: loaded w/ high priority as discussed here:
  ----               https://github.com/folke/lazy.nvim > Plugin Spec > priority
  {
    'catppuccin/nvim',

    lazy     = false,
    priority = Priority.THIRD,
  },
  {
    'rebelot/kanagawa.nvim',

    lazy     = false,
    priority = Priority.THIRD,
  },
  {
    'marko-cerovac/material.nvim',

    lazy     = false,
    priority = Priority.THIRD,
  },
  {
    'AlexvZyl/nordic.nvim',

    lazy     = false,
    priority = Priority.THIRD,
  },
  {
    'folke/tokyonight.nvim',

    lazy     = false,
    priority = Priority.THIRD,
  },
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

