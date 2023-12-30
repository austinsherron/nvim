local Project   = require 'plugins.extensions.project'
local Session   = require 'plugins.extensions.session'
local Telescope = require 'plugins.extensions.telescope'
local Builtins  = require 'telescope.builtin'
local KeyMapper = require 'utils.core.mapper'

local HintFmttr = require('plugins.extensions.hydra').HintFormatter


local KM = KeyMapper.new({
  desc_prefix = 'telescope: ',
  nowait      = true,
  silent      = true,
})

-- find ------------------------------------------------------------------------

KM:with_hydra({ name = '🔭 Telescope', body = '<leader>f' })
KM:with_hydra({ config = { hint = HintFmttr.bottom_3(), color = 'teal', esc = true }})
KM:bind({
  { 'a',  Builtins.builtin,                    { desc = 'search telescope built-ins'      }},
  { 'b',  Builtins.buffers,                    { desc = 'search buffers'                  }},
  { 'C',  Builtins.colorscheme,                { desc = 'search colorschemes'             }},
  { 'c',  '<cmd>Telescope aerial<CR>',         { desc = 'search code symbols'             }},
  { 'd',  Builtins.diagnostics,                { desc = 'search code symbols'             }},
  { 'e',  '<cmd>Telescope emoji<CR>',          { desc = 'search emojis'                   }},
  { 'F',  Telescope.contextual_find_all_files, { desc = 'search all files (hidden, etc.)' }},
  { 'f',  Telescope.contextual_find_files,     { desc = 'search files'                    }},
  { 'gc', Builtins.git_bcommits,               { desc = 'search git commits'              }},
  { 'gs', Builtins.git_stash,                  { desc = 'search git stashes'              }},
  { 'h',  Builtins.help_tags,                  { desc = 'search help tags'                }},
  { 'H',  '<cmd>Telescope undo<CR>',           { desc = 'search undo history'             }},
  { 'm',  Builtins.man_pages,                  { desc = 'search man pages'                }},
  { 'N',  Telescope.search_packages,           { desc = 'search plugin files'             }},
  { 'n',  '<cmd>Telescope notify<CR>',         { desc = 'search notification history'     }},
  { 'p',  Project.picker,                      { desc = 'search projects'                 }},
  { 'r',  '<cmd>Telescope frecency<CR>',       { desc = 'search "frecent"'                }},
  { 's',  Session.picker,                      { desc = 'search sessions'                 }},
  { 't',  Builtins.treesitter,                 { desc = 'search treesitter symbols'       }},
  { 'u',  Builtins.lsp_references,             { desc = 'find usages'                     }},
  { 'w',  Telescope.contextual_live_grep,      { desc = 'find words'                      }},
}):done()

-- remaps ----------------------------------------------------------------------

---@note:
KM:bind_one('<leader>ds', Builtins.spell_suggest, { desc = 'spelling suggestions' })

