-- editor ----------------------------------------------------------------------

--[[
  control core editor capabilities like commenting, completion, general text manipulation, etc.
--]]

local cmp = require 'nvim.lua.plugins.config.cmp.cmp'
local plugins = require('nvim.lua.utils.plugins.plugin').plugins


return plugins({
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
    dependencies = 'hrsh7th/nvim-cmp',
  },
---- cmp-calc: fuzzy completion of math calculation
  {
    'hrsh7th/cmp-calc',
    dependencies = 'hrsh7th/nvim-cmp',
  },
---- cmp-cmdline: fuzzy completion of commands
  {
    'hrsh7th/cmp-cmdline',
    dependencies = 'hrsh7th/nvim-cmp',
  },
-- cmp-"conventional commits": auto-completion for conventional git commit message terms
  {
    'davidsierradz/cmp-conventionalcommits',
    dependencies = { 'hrsh7th/nvim-cmp' },
  },
---- cmp-dictionary: fuzzy completion words in dictionary
  {
    'uga-rosa/cmp-dictionary',
    dependencies = 'hrsh7th/nvim-cmp',
  },
---- cmp-emoji: fuzzy completion of emojis
  {
    'hrsh7th/cmp-emoji',
    dependencies = 'hrsh7th/nvim-cmp',
  },
---- cmp-lsp: fuzzy completion based on available lsp servers
  {
    'hrsh7th/cmp-nvim-lsp',
    dependencies = 'hrsh7th/nvim-cmp',
  },
---- cmp-lsp-signature-help: displays function signature hover-help during relevant completion events
  {
    'hrsh7th/cmp-nvim-lsp-signature-help',
    dependencies = 'hrsh7th/nvim-cmp',
  },
---- cmp-path: fuzzy completion of file system paths
  {
    'hrsh7th/cmp-path',
    dependencies = 'hrsh7th/nvim-cmp',
  },
---- cmp-spell: fuzzy completion of spelling suggestions
  {
    'f3fora/cmp-spell',
    dependencies = 'hrsh7th/nvim-cmp',
  },
---- editor config: language specific file formatting
  { 'gpanders/editorconfig.nvim' },
---- neovim session-manager: persist open files/buffers b/w nvim sessions
  { 'Shatur/neovim-session-manager' },
---- surround: efficient manipulation of brackets, quotes, etc.
  {
    'kylechui/nvim-surround',
    version = '*', -- use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',

    config = function()
      require('nvim-surround').setup()
    end
  },
})

