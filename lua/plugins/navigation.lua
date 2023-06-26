-- navigation ------------------------------------------------------------------

--[[
   control (file) system (as opposed to on-screen) movement
--]]

require 'nvim.lua.plugins.config.nvimtmuxnav'
require 'nvim.lua.plugins.config.nvimtree'
require 'nvim.lua.plugins.config.project'


return {
---- nnn: file explorer w/ what seems like a cult-ish following
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
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = nvim_tree_opts(),

    config = function (_, opts)
      require('nvim-tree').setup(opts)
    end,
  },
---- project: project manager/navigator
  {
    'ahmedkhalf/project.nvim',
    opts = project_opts(),

    config = function(_, opts)
      require('project_nvim').setup(opts)
    end
  },
}

