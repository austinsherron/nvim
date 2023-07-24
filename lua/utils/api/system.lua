
--- Nearly non-existent wrapper around nvim functions related to system interactions.
--
---@class System
return {
  ---@see vim.fn.getcwd
  cwd    = vim.fn.getcwd,
  ---@see vim.fn.isdirectory
  is_dir = vim.fn.isdirectory,
  ---@see vim.fn.mkdir
  mkdir  = vim.fn.mkdir,
  ---@see vim.fn.run
  run    = vim.fn.system,
}

