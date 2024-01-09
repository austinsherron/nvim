local Git = require 'utils.api.git'
local Lazy = require 'plugins.config.tools.lazy'
local System = require 'utils.api.vim.system'

local LOGGER = GetLogger 'PLUGINS'

--- Responsible for plugin orchestration, as well as hiding the impl details of the Neovim
--- plugin manager.
---
---@class PluginMgr
local PluginMgr = {}

local function download(dst_path)
  local repo = Lazy.git_path()

  Git.clone(repo, dst_path, { filter = 'blob:none', branch = 'stable' })
  LOGGER:debug('Successfully downloaded %s', { repo })
end

--- Initializes the neovim plugin manager.
---
---@param plugins string|table: a string the path (relative or absolute [?]) to a lua
--- importable source (file or directory) of plugin definitions, or a table that already contains
--- plugin definitions.
function PluginMgr.init(plugins)
  LOGGER:debug 'Initializing plugin manager'
  local lazy_path = Lazy.lazy_path()

  if not System.stat(lazy_path) then
    LOGGER:warn('Plugin manager not found at=%s; fetching', { lazy_path })
    download(lazy_path)
  end

  System.add_to_rtp(lazy_path)
  require('lazy').setup(plugins, Lazy.opts())

  LOGGER:info 'Plugin manager initialized'
end

return PluginMgr
