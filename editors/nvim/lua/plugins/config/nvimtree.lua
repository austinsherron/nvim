function nvim_tree_settings()
  return {
    sort_by = 'case_sensitive',
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
  }
end

