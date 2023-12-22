local Project   = require 'plugins.extensions.project'
local Session   = require 'plugins.extensions.session'
local Telescope = require 'plugins.extensions.telescope'
local Builtins  = require 'telescope.builtin'
local KeyMapper = require 'utils.core.mapper'


local KM = KeyMapper.new({
  desc_prefix = 'telescope: ',
  nowait      = true,
  silent      = true,
})

-- find ------------------------------------------------------------------------

KM:bind({
  { '<leader>fa',  Builtins.builtin,                    { desc = 'search telescope built-ins'      }},
  { '<leader>fb',  Builtins.buffers,                    { desc = 'search buffers'                  }},
  { '<leader>fC',  Builtins.colorscheme,                { desc = 'search colorschemes'             }},
  { '<leader>fc',  '<cmd>Telescope aerial<CR>',         { desc = 'search code symbols'             }},
  { '<leader>fd',  Builtins.diagnostics,                { desc = 'search code symbols'             }},
  { '<leader>fe',  '<cmd>Telescope emoji<CR>',          { desc = 'search emojis'                   }},
  { '<leader>fF',  Telescope.contextual_find_all_files, { desc = 'search all files (hidden, etc.)' }},
  { '<leader>ff',  Telescope.contextual_find_files,     { desc = 'search files'                    }},
  { '<leader>fgc', Builtins.git_bcommits,               { desc = 'search git commits'              }},
  { '<leader>fgs', Builtins.git_stash,                  { desc = 'search git stashes'              }},
  { '<leader>fh',  Builtins.help_tags,                  { desc = 'search help tags'                }},
  { '<leader>fH',  '<cmd>Telescope undo<CR>',           { desc = 'search undo history'             }},
  { '<leader>fm',  Builtins.man_pages,                  { desc = 'search man pages'                }},
  { '<leader>fN',  Telescope.search_packages,           { desc = 'search plugin files'             }},
  { '<leader>fn',  '<cmd>Telescope notify<CR>',         { desc = 'search notification history'     }},
  { '<leader>fp',  Project.picker,                      { desc = 'search projects'                 }},
  { '<leader>fr',  '<cmd>Telescope frecency<CR>',       { desc = 'search "frecent"'                }},
  { '<leader>fs',  Session.picker,                      { desc = 'search sessions'                 }},
  { '<leader>ft',  Builtins.treesitter,                 { desc = 'search treesitter symbols'       }},
  { '<leader>fu',  Builtins.lsp_references,             { desc = 'find usages'                     }},
  { '<leader>fw',  Telescope.contextual_live_grep,      { desc = 'find words'                      }},
})

-- remaps ----------------------------------------------------------------------

---@note:
KM:bind_one('<leader>ds', Builtins.spell_suggest, { desc = 'spelling suggestions' })

