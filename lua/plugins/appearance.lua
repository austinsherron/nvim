-- appearance ------------------------------------------------------------------

--[[
  control how nvim looks: colors, icons, textures, menus, etc; distinct from
  interface in that interface elements should be functional (and ideally
  useful); appearance is the place for things that provide aesthetic value only
--]]

local lk       = require 'config.lspkind'
local plugins  = require('utils.plugins.plugin').plugins
local priority = require 'utils.plugins.priority'


return plugins({
---- colorschemes: loaded w/ high priority as discussed here:
----               https://github.com/folke/lazy.nvim > Plugin Spec > priority
  {
    'catppuccin/nvim',

    lazy = false,
    priority = priority.THIRD,
  },
  {
    'rebelot/kanagawa.nvim',

    lazy = false,
    priority = priority.THIRD,
  },
  {
    'AlexvZyl/nordic.nvim',

    lazy = false,
    priority = priority.THIRD,
  },
  {
    'folke/tokyonight.nvim',

    lazy = false,
    priority = priority.THIRD,
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
    opts = lk.opts(),

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
    priority = priority.FIRST,
  },
})

