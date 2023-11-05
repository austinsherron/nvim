
-- test ------------------------------------------------------------------------

--[[
  enable unit testing and related functionality
--]]

local Treesitter = require 'plugins.config.code.treesitter'
local Neotest    = require 'plugins.config.test.neotest'

local Plugins = require('utils.plugins.plugin').plugins

local TsPlugin = Treesitter.TreesitterPlugin


return Plugins({
  --- neotest: new-school nvim test runner/adapter
  {
    'nvim-neotest/neotest',
    enabled = Treesitter.enabled(TsPlugin.NEOTEST),

    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neotest/neotest-python',
      'nvim-neotest/neotest-vim-test',
      'nvim-treesitter/nvim-treesitter',
    },

    config = Neotest.config,
  },
  --- neotest-python: python test adapter
  { 'nvim-neotest/neotest-python' },
  --- neotest-vim-test: bridge b/w neotest and vim-test
  { 'nvim-neotest/neotest-vim-test' },
  --- vim-test: old-school vim test runner/adapter
  { 'vim-test/vim-test' },
})

