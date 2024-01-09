-- motion ----------------------------------------------------------------------

--[[
   control on-screen (as opposed to file-system) movement
--]]

local Flash = require 'plugins.config.motion.flash'
local NvimTmuxNav = require 'plugins.config.motion.nvimtmuxnav'

local Plugins = require('utils.plugins.plugin').plugins

return Plugins('motion', {
  ---- flash: another "fast movement" plugin; a replacement for leap? (yes)
  {
    'folke/flash.nvim',
    opts = Flash.opts(),

    config = function(_, opts)
      require('flash').setup(opts)
    end,
  },
  ---- nvim-tmux navigation: integration b/w nvim + tmux (pane nav shortcuts)
  {
    'alexghergh/nvim-tmux-navigation',
    opts = NvimTmuxNav.opts(),

    config = function(_, opts)
      require('nvim-tmux-navigation').setup(opts)
    end,
  },
})
