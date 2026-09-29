-- git -------------------------------------------------------------------------

--[[
  enable nvim git interactions/integrations
--]]

local CodeDiff = require 'plugins.config.git.codediff'
local Gitsigns = require 'plugins.config.git.gitsigns'
local Lazygit = require 'plugins.config.git.lazygit'
local Octo = require 'plugins.config.git.octo'

local Plugins = require('utils.plugins.plugin').plugins

return Plugins('git', {
  ---- codediff: vscode-style diff/review workspace
  {
    'esmuellert/codediff.nvim',
    version = '*',
    cmd = 'CodeDiff',
    opts = CodeDiff.opts(),

    config = function(_, opts)
      require('codediff').setup(opts)
    end,
  },
  ---- gitsigns: visual cues about what's changed/is changing
  {
    'lewis6991/gitsigns.nvim',
    opts = Gitsigns.opts(),

    config = function(_, opts)
      require('gitsigns').setup(opts)
    end,
  },
  ---- lazygit: nvim entry point to lazygit
  {
    'kdheepak/lazygit.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },

    config = Lazygit.config,
  },
  ---- octo: github issues/PRs from within nvim
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    opts = Octo.opts(),

    config = Octo.config,
  },
})
