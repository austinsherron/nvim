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
  }
end

