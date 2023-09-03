
-- workspace -------------------------------------------------------------------

--[[
  control capabilities related to managing and manipulating "workspace"
  elements, i.e.: buffers, tabs, windows, sessions, projects, and
  groupings/filtered views of the same
--]]

local Project    = require 'plugins.config.workspace.project'
local SessionMgr = require 'plugins.config.workspace.sessionmgr'
local Plugins    = require('utils.plugins.plugin').plugins


return Plugins({
  ---- neovim session-manager: persist open files/buffers b/w nvim sessions
  {
    'Shatur/neovim-session-manager',

    config = SessionMgr.config,
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

