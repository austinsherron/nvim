
-- git -------------------------------------------------------------------------

--[[
  enable nvim git interactions/integrations
--]]

local Diffview = require 'lua.plugins.config.diffview'
local Gitsigns = require 'lua.plugins.config.gitsigns'
local Neogit   = require 'lua.plugins.config.neogit'
local Plugins  = require('lua.utils.plugins.plugin').plugins


return Plugins({
---- diff view: for looking at diffs...
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    -- FIXME: these don't seem to be respected below...
    opts         = Diffview.opts(),

    config = function(_, opts)
      require('diffview').setup(opts)
    end
  },
---- gitsigns: visual cues about what's changed/is changing
  {
    'lewis6991/gitsigns.nvim',
    opts = Gitsigns.opts(),

    config = function(_, opts)
      require('gitsigns').setup(opts)
    end
  },
---- neogit: git interactions through neovim
  {
    'NeogitOrg/neogit',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts         = Neogit.opts(),

    config = function(_, opts)
      require('neogit').setup(opts)
    end
  },
})

