-- code ------------------------------------------------------------------------

--[[
  control nvim's ability to understand, generate, and generally interact w/ code
--]]

local aer = require 'nvim.lua.plugins.config.aerial'
local ls = require 'nvim.lua.plugins.config.luasnip'
local lsp = require 'nvim.lua.lsp'
local plugin = require 'nvim.lua.utils.plugin'
local mlsp = require 'nvim.lua.plugins.config.mason'
local ts = require 'nvim.lua.plugins.config.treesitter'


return {
---- aerial: code outlines
  plugin({
    'stevearc/aerial.nvim',
    opts = aer.opts(),
    dependencies = {
       'nvim-treesitter/nvim-treesitter',
       'nvim-tree/nvim-web-devicons'
    },

    config = function(_, opts)
      require('aerial').setup(opts)
    end
  }),
---- LuaSnip: snippets engine (...written in Lua)
  plugin({
    'L3MON4D3/LuaSnip',
    version = '<1>.*',
    build = 'make install_jsregexp',
    config = ls.config,
  }),
---- mason: package manager for lsp/dap servers, linters, formatters, etc.
  plugin({
    'williamboman/mason.nvim',
    build = ':MasonUpdate',

    config = function()
      require('mason').setup()
    end
  }),
---- mason lsp-config: integration b/w mason and nvim lsp-config
  plugin({
    'williamboman/mason-lspconfig.nvim',
    opts = mlsp.opts(),
    dependencies = { 'williamboman/mason.nvim' },

    config = function(_, opts)
      require('mason-lspconfig').setup(opts)
    end
  }),
---- nvim lsp-config: makes it easier to configure nvim's built in lsp (code semantics)
  plugin({
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason-lspconfig.nvim' },
    config = lsp.config,
  }),
---- nvim navic: for showing code context in status bar(s)
  plugin({
    'SmiteshP/nvim-navic',
    dependencies = 'neovim/nvim-lspconfig',

    config = function ()
      require('nvim-navic')
    end
  }),
---- treesitter: a parser that integrates w/ all kinds of things (i.e.: adds extra color, etc.)
  plugin({
    'nvim-treesitter/nvim-treesitter',
    opts = ts.opts(),

    build = function()
      require('nvim-treesitter.install').update(ts.build())
    end,

    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  }),
}

