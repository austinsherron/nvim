
--- Nearly non-existent wrapper around nvim functions related to system interactions.
---
---@class System
return {
  --- Adds path to the runtime path.
  ---@see vim.opt.rtp
  add_to_rtp = function(path) vim.opt.rtp:prepend(path) end,
  ---@see vim.api.nvim_set_current_dir
  cd         = vim.api.nvim_set_current_dir,
  ---@see vim.fn.getcwd
  cwd        = vim.fn.getcwd,
  --- Gets the path to the current file.
  get_current_file = function() return vim.fn.expand("%") end,
  ---@see vim.fn.isdirectory
  is_dir     = vim.fn.isdirectory,
  ---@see vim.fn.mkdir
  mkdir      = vim.fn.mkdir,
  ---@see vim.fn.run
  run        = vim.fn.system,
  ---@see vim.loop.fs_stat
  stat       = vim.loop.fs_stat,
  ---@see vim.fn.executable
  executable = vim.fn.executable,
}

