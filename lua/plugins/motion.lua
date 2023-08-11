
-- motion ----------------------------------------------------------------------

--[[
   control on-screen (as opposed to file-system) movement
--]]

local Leap        = require 'keymap.plugins.motion.leap'
local NvimTmuxNav = require 'plugins.config.nvimtmuxnav'
local Plugins     = require('utils.plugins.plugin').plugins


return Plugins({
---- leap: fast movement w/in files
  {
    'ggandor/leap.nvim',
    lazy = false,

    config = function()
      Leap.add_keymap()
    end
  },
---- nvim-tmux navigation: integration b/w nvim + tmux (pane nav shortcuts)
  {
    'alexghergh/nvim-tmux-navigation',
    opts = NvimTmuxNav.opts(),

    config = function(_, opts)
      require('nvim-tmux-navigation').setup(opts)
    end
  },
})

