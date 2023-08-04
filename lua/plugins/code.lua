
-- code ------------------------------------------------------------------------

--[[
  control nvim's ability to understand, generate, and generally interact w/ code
--]]

local Lsp        = require 'lua.lsp'
local Aerial     = require 'lua.plugins.config.aerial'
local LuaSnip    = require 'lua.plugins.config.luasnip'
local Mason      = require 'lua.plugins.config.mason'
local SnipRun    = require 'lua.plugins.config.sniprun'
local Treesitter = require 'lua.plugins.config.treesitter'
local TreeSJ     = require 'lua.plugins.config.treesj'
local Plugins    = require('lua.utils.plugins.plugin').plugins


return Plugins({
---- aerial: code outlines
  {
    'stevearc/aerial.nvim',
    opts         = Aerial.opts(),
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons'
    },

    config = function(_, opts)
      require('aerial').setup(opts)
    end
  },
---- LuaSnip: snippets engine (...written in Lua)
  {
    'L3MON4D3/LuaSnip',
    version = '<1>.*',
    build   = 'make install_jsregexp',
    config  = LuaSnip.config,
  },
---- mason: package manager for lsp/dap servers, linters, formatters, etc.
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',

    config = function()
      require('mason').setup()
    end
  },
---- mason lsp-config: integration b/w mason and nvim lsp-config
  ({
    'williamboman/mason-lspconfig.nvim',
    opts         = Mason.opts(),
    dependencies = { 'williamboman/mason.nvim' },

    config       = function(_, opts)
      require('mason-lspconfig').setup(opts)
    end
  }),
---- neodev: make lsp aware of (n)vim apis and plugins
  {
    'folke/neodev.nvim',
    opts = {},

    config = function(_, opts)
      require('neodev').setup(opts)
    end
  },
---- nvim lsp-config: makes it easier to configure nvim's built in lsp (code semantics)
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim',
    },
    config = Lsp.config,
  },
---- nvim navic: for showing code context in status bar(s)
  {
    'SmiteshP/nvim-navic',
    dependencies = { 'neovim/nvim-lspconfig' },

    config = function()
      require('nvim-navic')
    end
  },
---- sniprun: run snippets of code on the fly
  {
    'michaelb/sniprun',
    opts = SnipRun.opts(),
    build = 'bash install.sh',

    config = function(_, opts)
      require('sniprun').setup(opts)
    end
  },
---- treesitter: a parser that integrates w/ all kinds of things (i.e.: adds extra color, etc.)
  {
    'nvim-treesitter/nvim-treesitter',
    opts = Treesitter.opts(),

    build = function()
      require('nvim-treesitter.install').update(Treesitter.build())
    end,

    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
---- TreeSJ: split/join semantic blocks of code
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = TreeSJ.opts(),

    config = function(_, opts)
      require('treesj').setup(opts)
    end,
  },
})

