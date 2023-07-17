-- code ------------------------------------------------------------------------

--[[
  control nvim's ability to understand, generate, and generally interact w/ code
--]]

local aer     = require 'config.aerial'
local ls      = require 'config.luasnip'
local mlsp    = require 'config.mason'
local ts      = require 'config.treesitter'
local lsp     = require 'lsp'
local plugins = require('utils.plugins.plugin').plugins


return plugins({
---- aerial: code outlines
  {
    'stevearc/aerial.nvim',
    opts = aer.opts(),
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
    build = 'make install_jsregexp',
    config = ls.config,
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
    opts = mlsp.opts(),
    dependencies = { 'williamboman/mason.nvim' },

    config = function(_, opts)
      require('mason-lspconfig').setup(opts)
    end
  }),
---- nvim lsp-config: makes it easier to configure nvim's built in lsp (code semantics)
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason-lspconfig.nvim' },
    config = lsp.config,
  },
---- nvim navic: for showing code context in status bar(s)
  {
    'SmiteshP/nvim-navic',
    dependencies = { 'neovim/nvim-lspconfig' },

    config = function()
      require('nvim-navic')
    end
  },
---- treesitter: a parser that integrates w/ all kinds of things (i.e.: adds extra color, etc.)
  {
    'nvim-treesitter/nvim-treesitter',
    opts = ts.opts(),

    build = function()
      require('nvim-treesitter.install').update(ts.build())
    end,

    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
---- TreeSJ: split/join semantic blocks of code
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },

    config = function()
      require('treesj').setup()
    end,
  },
})

