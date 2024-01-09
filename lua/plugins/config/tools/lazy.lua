local Path = require 'utils.api.vim.path'

local GIT_PATH = 'folke/lazy.nvim'
local PLUGINS_PATH = Path.config() .. '/packages'
local LAZY_PATH = PLUGINS_PATH .. '/lazy.nvim'
local LOCKFILE_PATH = Path.config() .. '/.lazy-lockfile.json'

--- Contains functions for configuring the lazy.nvim plugin manager (a plugin itself 😃).
---
---@class Lazy
local Lazy = {}

---@return table: a table that contains configuration values for the lazy.nvim plugin
--- manager
function Lazy.opts()
  return {
    root = PLUGINS_PATH,
    lockfile = LOCKFILE_PATH,
  }
end

---@return string: the path to the repo on github.com
function Lazy.git_path()
  return GIT_PATH
end

---@return string: the path to the system's lazy.nvim installation
function Lazy.lazy_path()
  return LAZY_PATH
end

return Lazy
