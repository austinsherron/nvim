-- editor ----------------------------------------------------------------------

--[[
  control core editor capabilities like commenting, completion, general text manipulation, etc.
--]]

local cmp = require 'nvim.lua.plugins.config.cmp.cmp'
local plugin = require 'nvim.lua.utils.plugin'


return {
---- comment: manipulate code comments easily
  plugin({
    'numToStr/Comment.nvim',

    config = function()
      require('Comment').setup()
    end
  }),
---- cmp: completion engine
  plugin({
    'hrsh7th/nvim-cmp',
    config = cmp.config,
  }),
---- cmp-buffer: fuzzy completion of buffer contents
  plugin({ 'hrsh7th/cmp-buffer' }),
---- cmp-calc: fuzzy completion of math calculation
  plugin({ 'hrsh7th/cmp-calc' }),
---- cmp-cmdline: fuzzy completion of commands
  plugin({ 'hrsh7th/cmp-cmdline' }),
---- cmp-emoji: fuzzy completion of emojis
  plugin({ 'hrsh7th/cmp-emoji' }),
---- cmp-lsp: fuzzy completion based on available lsp servers
  plugin({ 'hrsh7th/cmp-nvim-lsp' }),
---- cmp-path: fuzzy completion of file system paths
  plugin({ 'hrsh7th/cmp-path' }),
---- cmp-spell: fuzzy completion of spelling suggestions
  plugin({ 'f3fora/cmp-spell' }),
---- editor config: language specific file formatting
  plugin({ 'gpanders/editorconfig.nvim', }),
---- neovim session-manager: persist open files/buffers b/w nvim sessions
  plugin({ 'Shatur/neovim-session-manager' }),
---- surround: efficient manipulation of brackets, quotes, etc.
  plugin({
    'kylechui/nvim-surround',
    version = '*', -- use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',

    config = function()
      require('nvim-surround').setup()
    end
  }),
}

