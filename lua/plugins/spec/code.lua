-- code ------------------------------------------------------------------------

--[[
  control nvim's ability to understand, generate, and generally interact w/ code
--]]

local Fidget = require 'plugins.config.code.fidget'
local LspSaga = require 'plugins.config.code.lspsaga'
local LuaSnip = require 'plugins.config.code.luasnip'
local Mason = require 'plugins.config.code.mason'
local Neodev = require 'plugins.config.code.neodev'
local SymbolsOutline = require 'plugins.config.code.outline'
local TreeSJ = require 'plugins.config.code.treesj'
local Treesitter = require 'plugins.config.code.treesitter'

local Plugins = require('utils.plugins.plugin').plugins

local TsPlugin = Treesitter.TreesitterPlugin

return Plugins('code', {
  ---- efm-configs: oob efm configs for formatters and linters
  {
    'creativenull/efmls-configs-nvim',
    dependencies = { 'neovim/nvim-lspconfig' },
  },
  ---- fidget: show lsp progress outside of statusline
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    event = 'LspAttach',
    opts = Fidget.opts(),

    config = function(_, opts)
      require('fidget').setup(opts)
    end,
  },
  ---- lspsaga: "improves the neovim built-in lsp experience"
  {
    'nvimdev/lspsaga.nvim',
    opts = LspSaga.opts(),
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },

    config = function(_, opts)
      require('lspsaga').setup(opts)
    end,
  },
  ---- LuaSnip: snippets engine (...written in Lua)
  {
    'L3MON4D3/LuaSnip',
    version = '<1>.*',
    build = 'make install_jsregexp',
    config = LuaSnip.config,
  },
  ---- mason: package manager for lsp/dap servers, linters, formatters, etc.
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',

    config = function()
      require('mason').setup()
    end,
  },
  ---- mason lsp-config: integration b/w mason and nvim lsp-config
  {
    'williamboman/mason-lspconfig.nvim',
    opts = Mason.opts(),
    dependencies = { 'williamboman/mason.nvim' },

    config = function(_, opts)
      require('mason-lspconfig').setup(opts)
    end,
  },
  ---- neodev: make lsp aware of (n)vim apis and plugins
  {
    'folke/neodev.nvim',
    dependencies = 'neovim/nvim-lspconfig',
    opts = Neodev.opts(),

    config = function(_, opts)
      require('neodev').setup(opts)
    end,
  },
  ---- nvim lsp-config: makes it easier to configure nvim's built in lsp (code semantics)
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim',
    },
  },
  ---- nvim navic: for showing code context in status bar(s)
  ---- TODO: trying out lspsaga's winbar; remove if I decide to stick w/ that
  {
    'SmiteshP/nvim-navic',
    enabled = false,
    dependencies = { 'neovim/nvim-lspconfig' },

    config = function()
      require 'nvim-navic'
    end,
  },
  ---- refactoring: extract/inline variable, functions, and blocks
  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-treesitter/nvim-treesitter' },
    },
    opts = {},

    config = function(_, opts)
      require('refactoring').setup(opts)
    end,
  },
  ---- ropevim: vim integration w/ python refactoring library
  ---- TODO: setup/configure
  ---- FIXME: was wreaking all kinds of havoc w/ python files
  {
    'python-rope/ropevim',
    enabled = false,
  },
  ---- symbols-outline: code outline using lsp
  {
    'simrat39/symbols-outline.nvim',
    opts = SymbolsOutline.opts(),

    config = function(_, opts)
      require('symbols-outline').setup(opts)
    end,
  },
  ---- treesitter: parser that integrates w/ all kinds of things (i.e.: adds hls, etc.)
  {
    'nvim-treesitter/nvim-treesitter',
    enabled = Treesitter.enabled(),
    opts = Treesitter.opts(),

    build = function()
      require('nvim-treesitter.install').update(Treesitter.build())
    end,

    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  ---- ts-terraform-doc: open terraform docs w/ the help of treesitter
  {
    'Afourcat/treesitter-terraform-doc.nvim',
    enabled = Treesitter.enabled(TsPlugin.TERRAFORM_DOC),
    -- NOTE: not enough config to warrant a standalone file/class
    opts = { command_name = 'TFDoc' },

    config = function(_, opts)
      require('treesitter-terraform-doc').setup(opts)
    end,
  },
  ---- TreeSJ: split/join semantic blocks of code
  {
    'Wansmer/treesj',
    enabled = Treesitter.enabled(TsPlugin.TREESJ),
    opts = TreeSJ.opts(),
    dependencies = { 'nvim-treesitter/nvim-treesitter' },

    config = function(_, opts)
      require('treesj').setup(opts)
    end,
  },
  ---- vim-helm: improved experience for helm + yaml (+ gotmpl + sprig)
  { 'towolf/vim-helm' },
  ---- yaml-companion: get, set, and auto-detect yaml schemas in buffers
  {
    'someone-stole-my-name/yaml-companion.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },
})
