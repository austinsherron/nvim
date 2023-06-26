local nvt = require 'nvim.lua.config.keymappings.nvimtree'


function nvim_tree_opts()
  return {
    actions = {
      open_file = {
        quit_on_open = false
      },
    },

    filters = {
      dotfiles = true,
    },

    on_attach = nvt.on_attach,

    respect_buf_cwd = true,     -- for projects integration

    renderer = {
      group_empty = true,
    },

    root_dirs = { '~/Workspace' },
    sort_by = 'case_sensitive',
    sync_root_with_cwd = true,

    -- for projects integration
    update_focused_file = {
      enable = true,
      update_root = true
    },

    view = {
      mappings = {
        custom_only = false,
        list = {
          { key = 'l', action = 'edit', action_cb = edit_or_open },
          { key = 'L', action = 'cd', action_cb = cd },
          { key = 'h', action = 'close_node' },
          { key = 'H', action = 'dir_up', action_cb = dir_up },
        },
      },

      number = true,
      relativenumber = true,
      width = 45,
    },
  }
end

