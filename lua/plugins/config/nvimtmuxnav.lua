
--- Contains functions for configuring the nvim-tmux nav plugin.
--
---@class NvimTmuxNav
local NvimTmuxNav = {}

---@return table: a table that contains configuration values for the nvim-tmux nav plugin
function NvimTmuxNav.opts()
  return {
    keybindings = {
      left  = '<C-h>',
      down  = '<C-j>',
      up    = '<C-k>',
      right = '<C-l>',

      last_active = '<C-\\>',
      next        = '<C-Space>',
    }
  }
end

return NvimTmuxNav

