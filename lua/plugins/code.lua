-- code ------------------------------------------------------------------------

--[[
  control nvim's ability to understand and interact w/ code
--]]

local ls = require 'nvim.lua.plugins.config.luasnip'
local lsp = require 'nvim.lua.config.lsp'
local mlsp = require 'nvim.lua.plugins.config.mason'
local ts = require 'nvim.lua.plugins.config.treesitter'


---- LuaSnip: snippets engine (...written in Lua)
return {
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
  {
    'williamboman/mason-lspconfig.nvim',
    opts = mlsp.opts(),
    dependencies = { 'williamboman/mason.nvim' },

    config = function(_, opts)
      require('mason-lspconfig').setup(opts)
    end
  },
  {
    'SmiteshP/nvim-navic',
    dependencies = 'neovim/nvim-lspconfig',

    config = function ()
      require('nvim-navic')
    end
  },
---- nvim lsp-config: makes it easier to configure nvim's built in lsp (code semantics)
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason-lspconfig.nvim' },
    config = lsp.config,
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
}

