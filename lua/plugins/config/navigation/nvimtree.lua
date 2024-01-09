local NvimTreeKM = require 'keymap.plugins.navigation.nvimtree'

--- Contains functions for configuring the nvimtree plugin.
---
---@class NvimTree
local NvimTree = {}

---@return table: a table that contains configuration values for the nvimtree plugin
function NvimTree.opts()
  return {
    actions = {
      open_file = {
        quit_on_open = false,
      },
    },

    diagnostics = {
      enable = true,
    },

    filters = {
      dotfiles = true,
    },

    on_attach = NvimTreeKM.on_attach,

    respect_buf_cwd = true, -- for projects integration

    renderer = {
      group_empty = true,
    },

    root_dirs = { '~/Workspace' },
    sort_by = 'case_sensitive',
    sync_root_with_cwd = true,

    -- for projects integration
    update_focused_file = {
      enable = true,
      update_root = true,
    },

    view = {
      relativenumber = true,
      width = 40,
    },
  }
end

return NvimTree
