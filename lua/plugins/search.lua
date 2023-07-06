-- search ----------------------------------------------------------------------

--[[
  make it easier to find things
--]]

local spctr = require 'nvim.lua.plugins.config.spectre'
local tsc = require 'nvim.lua.plugins.config.telescope'


return {
---- searchbox: ui/ux enhancements for standard search/replace
  {
    'VonHeikemen/searchbox.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
  },
---- spectre: pop-out search + optional replace
  {
    'nvim-pack/nvim-spectre',
    opts = spctr.opts(),
  },
---- telescope: fuzzy pop-out search
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = {
      'nvim-lua/plenary.nvim' ,
      'debugloop/telescope-undo.nvim',
    },
    opts = tsc.opts(),
    config = tsc.config,
  },
---- telescope-emoji: telescearch for emojis!
  { 'xiyaowong/telescope-emoji.nvim' },
---- telescope-"f"recency: telescearch frequently~recently used files
  {
    'nvim-telescope/telescope-frecency.nvim',
    dependencies = { 'kkharji/sqlite.lua' },
  }
}

