-- tools -----------------------------------------------------------------------

--[[
  plugins for misc. tools that add explicitly new functionality to nvim, as
  opposed to changing something about the way its core functions works; tools
  here don't fit into any other categories into which I've grouped "tool-type"
  plugins
--]]

local plugin = require 'nvim.lua.utils.plugin'
local tmpl = require 'nvim.lua.plugins.config.template'


return {
---- markdown preview: for previewing markdown documents 🤔
  plugin({
    'iamcco/markdown-preview.nvim',
    build = 'cd app && yarn install'
  }),
---- neogen: docstring generation
  plugin({
    'danymat/neogen',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = true,
  }),
---- TODO: template.nvim: file templates (I couldn't get this to work; revisit)
  plugin({
    'glepnir/template.nvim',
    enabled = false,
    cmd = { 'Template', 'TemProject' },
    opts = tmpl.opts(),

    config = function(_, opts)
      require('template').setup(opts)
    end
  }),
}

