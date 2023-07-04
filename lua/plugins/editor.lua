-- editor ----------------------------------------------------------------------

--[[
  control core editor capabilities like commenting, general text manipulation, etc.
--]]

local cmp = require 'nvim.lua.plugins.config.cmp.cmp'


return {
---- comment: manipulate code comments easily
  {
    'numToStr/Comment.nvim',

    config = function()
      require('Comment').setup()
    end
  },
---- cmp: completion engine
  {
    'hrsh7th/nvim-cmp',
    config = cmp.config,
  },
---- cmp-buffer: fuzzy completion of buffer contents
  {
    'hrsh7th/cmp-buffer',
  },
---- cmp-calc: fuzzy completion of math calculation
  {
    'hrsh7th/cmp-calc',
  },
---- cmp-cmdline: fuzzy completion of commands
  {
    'hrsh7th/cmp-cmdline',
  },
---- cmp-emoji: fuzzy completion of emojis
  {
    'hrsh7th/cmp-emoji',
  },
---- cmp-lsp: fuzzy completion based on available lsp servers
  {
    'hrsh7th/cmp-nvim-lsp',
  },
---- cmp-path: fuzzy completion of file system paths
  {
    'hrsh7th/cmp-path',
  },
---- cmp-spell: fuzzy completion of spelling suggestions
  {
    'f3fora/cmp-spell',
  },
---- editor config: language specific file formatting
  {
    'gpanders/editorconfig.nvim',
  },
---- neovim session-manager: persist open files/buffers b/w nvim sessions
    'Shatur/neovim-session-manager',
---- surround: efficient manipulation of brackets, quotes, etc.
  {
    'kylechui/nvim-surround',
    version = '*', -- use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',

    config = function()
      require('nvim-surround').setup()
    end
  },
}

