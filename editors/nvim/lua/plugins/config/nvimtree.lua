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

    respect_buf_cwd = true,         -- for projects integration

    renderer = {
      group_empty = true,
    },

    root_dirs = { '~/sigma', '~/Workspace' },
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
              { key = 'L', action = 'vsplit_preview', action_cb = vsplit_preview },
              { key = 'h', action = 'close_node' },
              { key = 'H', action = 'collapse_all', action_cb = collapse_all },
          },
      },

      number = true,
      relativenumber = true,
      width = 37,
    },
  }
end

