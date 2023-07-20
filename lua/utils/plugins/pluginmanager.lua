
--- Responsible for plugin orchestration, as well as hiding the impl details of the Neovim
--  plugin manager.
--
---@class PluginMgr
local PluginMgr = {}

--- Initializes the neovim plugin manager.
--
---@param plugins string|table: a string the path (relative or absolute [?]) to a lua
-- importable source (file or directory) of plugin definitions, or a table that already contains
-- plugin definitions.
function PluginMgr.init(plugins)
  local base = vim.fn.stdpath('config')
  local pathbase = base .. '/packages'
  local lazypath = pathbase .. '/lazy.nvim'

  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  require('lazy').setup(plugins, {
    root = pathbase,
    lockfile = base .. '/.lazy-lockfile.json'
  })
end

return PluginMgr

