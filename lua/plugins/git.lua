-- git -------------------------------------------------------------------------

--[[
  enable nvim git interactions/integrations
--]]

require 'lib.lua.core.table'

local gs = require 'nvim.lua.plugins.config.gitsigns'
local ng = require 'nvim.lua.plugins.config.neogit'


return {
---- diff view: for looking at diffs...
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },

    config = function()
      require('diffview').setup({})
    end
  },
---- gitsigns: visual cues about what's changed/is changing
  {
    'lewis6991/gitsigns.nvim',
    opts = gs.opts(),

    config = function(_, opts)
      require('gitsigns').setup(opts)
    end
  },
---- neogit: git interactions through neovim
  {
    'NeogitOrg/neogit',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = ng.opts(),

    config = function(_, opts)
      require('neogit').setup(opts)
    end
  },
}

