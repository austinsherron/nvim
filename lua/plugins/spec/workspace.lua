-- workspace -------------------------------------------------------------------

--[[
  control capabilities related to managing and manipulating "workspace"
  elements, i.e.: buffers, tabs, windows, sessions, projects, and
  groupings/filtered views of the same
--]]

local Persisted = require 'plugins.config.workspace.persisted'
local Project = require 'plugins.config.workspace.project'

local Plugins = require('utils.plugins.plugin').plugins

return Plugins('workspace', {
  ---- persisted: session manager forked from persistence.nvim (from the legendary folke)
  {
    'olimorris/persisted.nvim',
    event = 'VimEnter',
    opts = Persisted.opts(),

    config = function(_, opts)
      require('persisted').setup(opts)
    end,
  },
  ---- project: project manager/navigator
  {
    'ahmedkhalf/project.nvim',
    opts = Project.opts(),

    config = function(_, opts)
      require('project_nvim').setup(opts)
    end,
  },
  ---- scope: enhanced buffer + tab workflows
  {
    'tiagovla/scope.nvim',
    opts = {},

    config = function(_, opts)
      require('scope').setup(opts)
    end,
  },
})
