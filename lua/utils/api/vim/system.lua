---@diagnostic disable: undefined-field

local Shell = require 'toolbox.system.shell'

local enum = require('toolbox.extensions.enum').enum

--- The scope at which to set the directory when cd'ing.
---
---@enum DirScope
local DirScope = enum({
  GLOBAL = 'global',
  TAB = 'tcd',
  WIN = 'lcd',
}, 'TAB')

local function cd(dir, scope)
  scope = DirScope:or_default(scope)

  if scope == DirScope.GLOBAL then
    return vim.api.nvim_set_current_dir(dir)
  end

  vim.cmd(scope .. ' ' .. dir)
end

--- Nearly non-existent wrapper around nvim functions related to system interactions.
---
---@class System
return {
  ---@note: for use w/ cd
  DirScope = DirScope,
  --- Adds path to the runtime path.
  ---@see vim.opt.rtp
  add_to_rtp = function(path)
    vim.opt.rtp:prepend(path)
  end,
  ---@see vim.api.nvim_set_current_dir
  cd = cd,
  ---@see Shell.chmod_x
  chmod_x = Shell.chmod_x,
  ---@see vim.fn.getcwd
  cwd = vim.fn.getcwd,
  --- Gets the path to the current file.
  get_current_file = function()
    return vim.fn.expand '%'
  end,
  ---@see vim.fn.isdirectory
  is_dir = vim.fn.isdirectory,
  ---@see vim.fn.mkdir
  mkdir = vim.fn.mkdir,
  ---@see vim.fn.run
  run = vim.fn.system,
  ---@see vim.loop.fs_stat
  stat = vim.loop.fs_stat,
  ---@see vim.fn.executable
  executable = vim.fn.executable,
}
