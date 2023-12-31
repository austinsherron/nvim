
-- motion ----------------------------------------------------------------------

--[[
   control on-screen (as opposed to file-system) movement
--]]

local FlashKM     = require 'keymap.plugins.motion.flash'
local LeapKM      = require 'keymap.plugins.motion.leap'
local Flash       = require 'plugins.config.motion.flash'
local NvimTmuxNav = require 'plugins.config.motion.nvimtmuxnav'

local Plugins = require('utils.plugins.plugin').plugins


return Plugins('motion', {
  --- flash: another "fast movement" plugin; a replacement for leap? (yes)
  {
    'folke/flash.nvim',
    opts = Flash.opts(),

    config = function(_, opts)
      require('flash').setup(opts)
      FlashKM.add_keymap()
    end
  },
  ---- leap: fast movement w/in files; note: disabled in favor of flash
  {
    'ggandor/leap.nvim',
    enabled = false,
    lazy    = false,

    config = function()
      LeapKM.add_keymap()
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

