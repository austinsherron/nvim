-- code ------------------------------------------------------------------------

--[[
  control nvim's ability to understand and interact w/ code
--]]

require 'nvim.lua.config.lsp'
require 'nvim.lua.plugins.config.mason'
local ts_opts = require 'nvim.lua.plugins.config.treesitter'


return {
---- mason: package manager for lsp/dap servers, linters, formatters, etc.
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',

    config = function()
      require('mason').setup()
    end
  },
---- mason lsp-config: integration b/w masion and nvim lspconfig
  {
    'williamboman/mason-lspconfig.nvim',
    opts = mason_lspconfig_opts(),
    dependencies = { 'williamboman/mason.nvim' },

    config = function(_, opts)
      require('mason-lspconfig').setup(opts)
    end
  },
---- nvim lsp-config: makes it easier to configure nvim's built in lsp (code semantics)
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason-lspconfig.nvim' },
    config = lspconfig_config,
  },
---- treesitter: a parser that integrates w/ all kinds of things (i.e.: adds extra color, etc.)
  {
    'nvim-treesitter/nvim-treesitter',
    opts = ts_opts.config(),

    build = function()
      require('nvim-treesitter.install').update(ts_opts.build())
    end,

    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}

