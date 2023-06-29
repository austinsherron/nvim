-- motion ----------------------------------------------------------------------

--[[
   control on-screen (as opposed to file-system) movement
--]]

local ntn = require 'nvim.lua.plugins.config.nvimtmuxnav'


return {
---- leap: fast movement w/in files
  {
    'ggandor/leap.nvim',
    lazy = false,

    config = function()
      require('leap').add_default_mappings()
    end
  },
---- nvim-tmux navigation: integration b/w nvim + tmux (pane nav shortcuts)
  {
    'alexghergh/nvim-tmux-navigation',
    opts = ntn.opts(),

    config = function(_, opts)
      require('nvim-tmux-navigation').setup(opts)
    end
  },
}

