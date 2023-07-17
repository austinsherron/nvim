-- g(it -------------------------------------------------------------------------

--[[
  enable nvim git interactions/integrations
--]]

local dv      = require 'config.diffview'
local gs      = require 'config.gitsigns'
local ng      = require 'config.neogit'
local plugins = require('utils.plugins.plugin').plugins


return plugins({
---- diff view: for looking at diffs...
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    -- FIXME: these don't seem to be respected below...
    opts = dv.opts(),

    config = function(_, opts)
      require('diffview').setup(opts)
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
})

