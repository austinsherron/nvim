
-- tools -----------------------------------------------------------------------

--[[
  plugins for misc. tools that add explicitly new functionality to nvim, as
  opposed to changing something about the way its core functions works; tools
  here don't fit into any other categories into which I've grouped "tool-type"
  plugins
--]]

local Template = require 'config.template'
local Plugins  = require('utils.plugins.plugin').plugins


return Plugins({
---- markdown preview: for previewing markdown documents 🤔
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && yarn install',
  },
---- neogen: docstring generation
  {
    'danymat/neogen',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config       = true,
  },
---- TODO: template.nvim: file templates (I couldn't get this to work; revisit)
  {
    'glepnir/template.nvim',
    enabled = false,
    cmd     = { 'Template', 'TemProject' },
    opts    = Template.opts(),

    config = function(_, opts)
      require('template').setup(opts)
    end
  },
})

