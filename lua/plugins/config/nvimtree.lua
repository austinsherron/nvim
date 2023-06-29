local nvt = require 'nvim.lua.config.keymappings.plugins.nvimtree'


local function opts()
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
      number = true,
      relativenumber = true,
      width = 45,
    },
  }
end


return {
  opts = opts,
}

