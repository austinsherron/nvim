
-- tools -----------------------------------------------------------------------

--[[
  plugins for misc tools that add explicitly new functionality to nvim, as
  opposed to changing something about the way its core functions works; tools
  here don't fit into any other categories into which I've grouped "tool-type"
  plugins
--]]

local Treesitter = require 'plugins.config.code.treesitter'

local Plugins = require('utils.plugins.plugin').plugins


return Plugins({
  ---- 1password: integrates 1pw w/ nvim
  {
    'mrjones2014/op.nvim',
    build = 'make install',
    opts = {},

    config = function(_, opts)
      require('op').setup(opts)
    end
  },
  ---- colorizer: high perf color highlighter
  ---- TODO: configure
  {
    'norcalli/nvim-colorizer.lua',
    opts = {},

    config = function(_, opts)
      require('colorizer').setup(opts)
    end
  },
  ---- link visitor: open links from nvim
  {
    'xiyaowong/link-visitor.nvim',
    -- not enough config to warrant a standalone file/class
    opts = { skip_confirmation = true },

    config = function(_, opts)
      require('link-visitor').setup(opts)
    end
  },
  ---- markdown preview: for previewing markdown documents 🤔
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && yarn install',
  },
  ---- neogen: docstring generation
  {
    'danymat/neogen',
    enabled      = Treesitter.enabled(),
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config       = true,
  },
  ---- plenary.nvim: lua utilities; a dependency for many, many plugins...
  { 'nvim-lua/plenary.nvim' },
})

