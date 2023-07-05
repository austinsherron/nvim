-- search ----------------------------------------------------------------------

--[[
  make it easier to find things
--]]

local tsc = require 'nvim.lua.plugins.config.telescope'


return {
---- spectre: pop-out search + optional replace
  {
    'nvim-pack/nvim-spectre'
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

