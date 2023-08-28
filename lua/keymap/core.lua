local KeyMapper = require 'utils.core.mapper'


local KM = KeyMapper.new({ desc_prefix = 'core: ', nowait = true })

-- interactions ---------------------------------------------------------------

-- core ops --

KM:bind({
  -- save
  { '<leader>w', ':w<CR>',    { desc = 'save one'        }},
  { '<M-w>',     ':w<CR>',    { desc = 'save one'        }},
  { '<leader>W', ':wqa!<CR>', { desc = 'save all + quit' }},
  -- close/quit
  { '<leader>q', ':q<CR>',   { desc = 'quit/close'     }},
  { '<leader>Q', ':qa<CR>',  { desc = 'quit/close all' }},
  { '<leader>!', ':qa!<CR>', { desc = 'force quit'     }},
  -- <esc>
  { 'jh',    '<Esc>', { desc = 'exit/back' }, { 'i' }},
  { 'hj',    '<Esc>', { desc = 'exit/back' }, { 'i' }},
  { 'jk',    '<Esc>', { desc = 'exit/back' }, { 'i' }},
  { 'kj',    '<Esc>', { desc = 'exit/back' }, { 'i' }},
  { '<C-c>', '<Esc>', { desc = 'exit/back' }, { 'i' }},
})

-- misc ops --

KM:bind({
  -- toggle relative line numbers
  { '<C-N><C-N>', ':set invrelativenumber<CR>', { desc = 'toggle relative line #' }},
  -- close quickfix window
  { '<leader>cx', ':cclose<CR>',                { desc = 'close quickfix window'  }},
  -- enter column edit mode
  { '<leader>v',  '<C-v>',                      { desc = 'enter column edit mode' }},
})

-- motion ----------------------------------------------------------------------

-- wrapped lines --

KM:bind({
  -- lets j and k move inside a visually wrapped line
  { 'j', 'gj', { desc = 'cursor down' }},
  { 'k', 'gk', { desc = 'cursor up'   }},
})

-- display --------------------------------------------------------------------

-- turn off highlight (i.e.: for search, as wall as for searchbox.nvim plugin)
KM:bind_one('<leader>hx', ':noh | :SearchBoxClear<CR>', { desc = 'cancel highlight' })

-- spellcheck ------------------------------------------------------------------

-- add word
KM:bind_one('<leader>sa', 'zg', { desc = 'add word to dict.' })
-- suggest words; note: handled in keymap/plugins/telescope.lua
-- KM.nnoremap('<leader>su', 'z=', options('suggest word(s) for typo'))

-- buffers ---------------------------------------------------------------------

-- note: since all other buffer key bindings are dependent on the barbar plugin,
--       they're defined w/ the barbar plugin keymap

-- resize
KM:bind({
  { '<leader><C-K>', ':resize -10<CR>',          { desc = 'resize "up" 10'    }},
  { '<leader><C-J>', ':resize +10<CR>',          { desc = 'resize "down" 10'  }},
  { '<leader><C-L>', ':vertical resize +10<CR>', { desc = 'resize "left" 10'  }},
  { '<leader><C-H>', ':vertical resize -10<CR>', { desc = 'resize "right" 10' }},
})

