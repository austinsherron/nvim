
-- code ------------------------------------------------------------------------

--[[
  control nvim's ability to understand, generate, and generally interact w/ code
--]]

local Lsp            = require 'lsp'
local Aerial         = require 'plugins.config.code.aerial'
local Fidget         = require 'plugins.config.code.fidget'
local LuaSnip        = require 'plugins.config.code.luasnip'
local Mason          = require 'plugins.config.code.mason'
local SnipRun        = require 'plugins.config.code.sniprun'
local SymbolsOutline = require 'plugins.config.code.outline'
local Treesitter     = require 'plugins.config.code.treesitter'
local TreeSJ         = require 'plugins.config.code.treesj'

local Plugins = require('utils.plugins.plugin').plugins

local TsPlugin = Treesitter.TreesitterPlugin


return Plugins('code', {
  ---- aerial: code outline (disabled while I try out symbols-outline)
  {
    'stevearc/aerial.nvim',
    enabled      = Treesitter.enabled(TsPlugin.AERIAL),
    opts         = Aerial.opts(),
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'nvim-treesitter/nvim-treesitter',
    },

    config = function(_, opts)
      require('aerial').setup(opts)
    end
  },
  ---- fidget: show lsp progress outside of statusline
  {
    'j-hui/fidget.nvim',
    tag   = 'legacy',
    event = 'LspAttach',
    opts  = Fidget.opts(),

    config = function(_, opts)
      require('fidget').setup(opts)
    end,
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
  {
    'williamboman/mason-lspconfig.nvim',
    opts         = Mason.opts(),
    dependencies = { 'williamboman/mason.nvim' },

    config = function(_, opts)
      require('mason-lspconfig').setup(opts)
    end
  },
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
    opts  = SnipRun.opts(),
    build = 'bash install.sh',

    config = function(_, opts)
      require('sniprun').setup(opts)
    end
  },
  ---- symbols-outline: code outline using lsp
  {
    'simrat39/symbols-outline.nvim',
    opts = SymbolsOutline.opts(),

    config = function(_, opts)
      require('symbols-outline').setup(opts)
    end,
  },
  ---- treesitter: a parser that integrates w/ all kinds of things (i.e.: adds extra color, etc.)
  {
    'nvim-treesitter/nvim-treesitter',
    enabled = Treesitter.enabled(),
    opts    = Treesitter.opts(),

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
    enabled      = Treesitter.enabled(TsPlugin.TREESJ),
    opts         = TreeSJ.opts(),
    dependencies = { 'nvim-treesitter/nvim-treesitter' },

    config = function(_, opts)
      require('treesj').setup(opts)
    end,
  },
})

