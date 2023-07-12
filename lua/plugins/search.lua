-- search ----------------------------------------------------------------------

--[[
  make it easier to find things
--]]

local plugin = require 'nvim.lua.utils.plugin'
local tsc = require 'nvim.lua.plugins.config.telescope'


return {
---- searchbox: ui/ux enhancements for standard search/replace
  plugin({
    'VonHeikemen/searchbox.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
  }),
---- spectre: pop-out search + optional replace
  plugin({ 'nvim-pack/nvim-spectre' }),
---- telescope: fuzzy pop-out search
  plugin({
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = {
      'nvim-lua/plenary.nvim' ,
      'debugloop/telescope-undo.nvim',
    },
    opts = tsc.opts(),
    config = tsc.config,
  }),
---- telescope-emoji: telescearch for emojis!
  plugin({ 'xiyaowong/telescope-emoji.nvim' }),
---- telescope-"f"recency: telescearch frequently~recently used files
  plugin({
    'nvim-telescope/telescope-frecency.nvim',
    dependencies = { 'kkharji/sqlite.lua' },
  })
}

