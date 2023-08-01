local GitsignsKM = require 'keymap.plugins.git.gitsigns'


--- Contains functions for configuring the gitsigns plugin.
---
---@class Gitsigns
local Gitsigns = {}

---@return table: a table that contains configuration values for the gitsigns plugin
function Gitsigns.opts()
  return {
    on_attach = GitsignsKM.on_attach,
    signs     = {
      add          = { text = '│' },
      change       = { text = '│' },
      delete       = { text = '_' },
      topdelete    = { text = '‾' },
      changedelete = { text = '~' },
      untracked    = { text = '┆' },
    },

    signcolumn   = true,  -- toggle with `:Gitsigns toggle_signs`
    numhl        = true,  -- toggle with `:Gitsigns toggle_numhl`
    linehl       = false, -- toggle with `:Gitsigns toggle_linehl`
    word_diff    = false, -- toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      interval     = 1000,
      follow_files = true
    },

    attach_to_untracked     = true,
    -- toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame      = false,
    current_line_blame_opts = {
      virt_text         = true,
      -- 'eol' | 'overlay' | 'right_align'
      virt_text_pos     = 'eol',
      delay             = 1000,
      ignore_whitespace = false,
    },

    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',

    sign_priority    = 6,
    update_debounce  = 100,
    -- use default
    status_formatter = nil,
    -- disable if file is longer than this (in lines)
    max_file_length  = 40000,
    preview_config   = {
      -- options passed to nvim_open_win
      border   = 'single',
      style    = 'minimal',
      relative = 'cursor',
      row      = 0,
      col      = 1
    },

    yadm = {
      enable = false
    },
  }
end

return Gitsigns

