-- git -------------------------------------------------------------------------

--[[
  enable nvim git interactions/integrations
--]]

require 'lib.lua.table'
require 'nvim.lua.plugins.config.gitsigns'

local gs = require 'nvim.lua.config.keymappings.plugins.gitsigns'


local function gitsigns_config(_, opts)
  local all_settings = table.combine({ on_attach = gs.on_attach }, opts)

  require('gitsigns').setup(all_settings)
end


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
    opts = gitsigns_opts(),
    config = gitsigns_config,
  },
}

