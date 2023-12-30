
-- search ----------------------------------------------------------------------

--[[
  make it easier to find things
--]]

local Telescope = require 'plugins.config.search.telescope'

local Plugins = require('utils.plugins.plugin').plugins


return Plugins({
  ---- searchbox: ui/ux enhancements for standard search/replace
  {
    'VonHeikemen/searchbox.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
  },
  ---- spectre: pop-out search + optional replace
  { 'nvim-pack/nvim-spectre' },
  ---- telescope: fuzzy pop-out search
  {
    'nvim-telescope/telescope.nvim',
    tag          = '0.1.1',
    dependencies = {
      'debugloop/telescope-undo.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-tree.lua',
    },
    config = Telescope.config,
  },
  ---- telescope-emoji: telescearch for emojis!
  { 'xiyaowong/telescope-emoji.nvim' },
  ---- telescope-"f"recency: telescearch frequently~recently used files
  {
    'nvim-telescope/telescope-frecency.nvim',
    dependencies = { 'kkharji/sqlite.lua' },
  }
})

