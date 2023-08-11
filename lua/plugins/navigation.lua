
-- navigation ------------------------------------------------------------------

--[[
   control (file) system (as opposed to on-screen) movement
--]]

local NvimTree = require 'plugins.config.navigation.nvimtree'
local Project  = require 'plugins.config.navigation.project'
local Plugins  = require('utils.plugins.plugin').plugins


return Plugins({
---- nnn: file explorer w/ what seems like a cult-ish following

---- note: didn't love the nnn interface; perhaps I need to use it a bit more
----       to become accustomed to it
  {
    'luukvbaal/nnn.nvim',
    enabled = false,

    config = function()
      require('nnn').setup()
    end
  },
---- nvim-tree: file explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    version      = '*',
    opts         = NvimTree.opts(),

    config = function(_, opts)
      require('nvim-tree').setup(opts)
    end,
  },
---- project: project manager/navigator
  {
    'ahmedkhalf/project.nvim',
    opts = Project.opts(),

    config = function(_, opts)
      require('project_nvim').setup(opts)
    end
  },
})

