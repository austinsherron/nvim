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
  { '<C-N><C-N>', ':set invrelativenumber<CR>', { desc = 'toggle relative line #' }},
  { '<leader>cx', ':cclose<CR>',                { desc = 'close quickfix window'  }},
  { '<leader>v',  '<C-v>',                      { desc = 'enter column edit mode' }},
})

-- motion ----------------------------------------------------------------------

-- wrapped lines --

KM:bind({
  -- lets j and k move inside a visually wrapped line
  { 'j', 'gj', { desc = 'cursor down (wrapped)' }},
  { 'k', 'gk', { desc = 'cursor up (wrapped)'   }},
})

-- display --------------------------------------------------------------------

-- turn off highlight (i.e.: for search, as wall as for searchbox.nvim plugin)
KM:bind_one('<leader>hx', ':noh | :SearchBoxClear<CR>', { desc = 'cancel highlight' })

-- buffers ---------------------------------------------------------------------

-- note: since all other buffer key bindings are dependent on the barbar plugin,
--       they're defined w/ the barbar plugin keymap

-- open splits
KM:bind({
  { '<leader>bh', ':split<CR>',  { desc = 'open horizontal split' }},
  { '<leader>bv', ':vsplit<CR>', { desc = 'open vertical split'   }},
})

-- resize
KM:bind({
  { '<C-r>j', ':resize -2<CR>',           { desc = 'resize "up" 2'     }},
  { '<C-r>k', ':resize +2<CR>',           { desc = 'resize "down" 2'   }},
  { '<C-r>l', ':vertical resize +2<CR>',  { desc = 'resize "left" 2'   }},
  { '<C-r>h', ':vertical resize -2<CR>',  { desc = 'resize "right" 2'  }},
  { '<C-r>J', ':resize -10<CR>',          { desc = 'resize "up" 10'    }},
  { '<C-r>K', ':resize +10<CR>',          { desc = 'resize "down" 10'  }},
  { '<C-r>L', ':vertical resize +10<CR>', { desc = 'resize "left" 10'  }},
  { '<C-r>H', ':vertical resize -10<CR>', { desc = 'resize "right" 10' }},
})

-- spellcheck ------------------------------------------------------------------

KM:with({ desc_prefix = 'spelling: ' })
KM:bind({
  { '<leader>da', 'zg',  { desc = 'add word to dict'                }},
  { '<leader>dr', 'zug', { desc = 'remove word from dict'           }},
  ---@note: overridden in handled in keymap/plugins/telescope.lua
  -- FIXME: modifications to key mapper that added support for 'ignore' were totally fucked
  -- { '<leader>dr', 'zg',  { desc = 'show suggestions', ignore = true }},
}):done()

