function nvim_tree_opts()
  return {
    root_dirs = { '~/sigma', '~/Workspace' },
    sort_by = 'case_sensitive',

    filters = {
      dotfiles = true,
    },

    renderer = {
      group_empty = true,
    },

    view = {
      width = 37,
      number = true,
      relativenumber = true,
    },

    -- for projects integration
    sync_root_with_cwd = true,
    respect_buf_cwd = true,

    update_focused_file = {
      enable = true,
      update_root = true
    },
  }
end

