-- navigation ------------------------------------------------------------------

--[[
   control (file) system (as opposed to on-screen) movement
--]]

local nvt = require 'nvim.lua.plugins.config.nvimtree'
local plugin = require 'nvim.lua.utils.plugin'
local proj = require 'nvim.lua.plugins.config.project'


return {
---- nnn: file explorer w/ what seems like a cult-ish following

---- note: didn't love the nnn interface; perhaps I need to use it a bit more
----       to become accustomed to it
  plugin({
    'luukvbaal/nnn.nvim',
    enabled = false,

    config = function()
      require('nnn').setup()
    end
  }),
---- nvim-tree: file explorer
  plugin({
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    version = '*',
    opts = nvt.opts(),

    config = function (_, opts)
      require('nvim-tree').setup(opts)
    end,
  }),
---- project: project manager/navigator
  plugin({
    'ahmedkhalf/project.nvim',
    opts = proj.opts(),

    config = function(_, opts)
      require('project_nvim').setup(opts)
    end
  }),
}

