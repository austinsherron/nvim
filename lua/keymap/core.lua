local KeyMapper = require 'utils.core.mapper'
local View = require 'utils.api.vim.view'

local KM = KeyMapper.new({ desc_prefix = 'core: ', nowait = true })

-- interactions ---------------------------------------------------------------

-- core ops --

KM:bind({
  -- save
  { '<leader>w', ':w<CR>', { desc = 'save one' } },
  { '<M-w>', ':w<CR>', { desc = 'save one' } },
  { '<leader>W', ':wqa!<CR>', { desc = 'save all + quit' } },
  -- close/quit
  { '<leader>e', View.close, { desc = 'close buffer + window' } },
  { '<leader>q', ':q<CR>', { desc = 'quit/close' } },
  { '<leader>Q', ':qa<CR>', { desc = 'quit/close all' } },
  { '<leader>!', ':qa!<CR>', { desc = 'force quit' } },
  -- <esc>
  { 'jh', '<Esc>', { desc = 'exit/back' }, { 'i' } },
  { 'hj', '<Esc>', { desc = 'exit/back' }, { 'i' } },
  { 'jk', '<Esc>', { desc = 'exit/back' }, { 'i' } },
  { 'kj', '<Esc>', { desc = 'exit/back' }, { 'i' } },
  { '<C-c>', '<Esc>', { desc = 'exit/back' }, { 'i' } },
})

-- misc ops --

KM:bind({
  { '<C-N><C-N>', ':set invrelativenumber<CR>', { desc = 'toggle relative line #' } },
  { '<leader>co', ':copen<CR>', { desc = 'open quickfix window' } },
  { '<leader>cx', ':cclose<CR>', { desc = 'close quickfix window' } },
  { '<leader>v', '<C-v>', { desc = 'enter column edit mode' } },
})

-- motion ----------------------------------------------------------------------

-- wrapped lines --

KM:bind({
  -- lets j and k move inside a visually wrapped line
  { 'j', 'gj', { desc = 'cursor down (wrapped)' } },
  { 'k', 'gk', { desc = 'cursor up (wrapped)' } },
})

-- display --------------------------------------------------------------------

-- turn off highlight (i.e.: for search, as wall as for searchbox.nvim plugin)
-- note: commented out here because it's bound with searchbox plugin key bindings

-- KM:bind_one('<leader>hx', ':noh | :SearchBoxClear<CR>', { desc = 'cancel highlight' })

-- buffers ---------------------------------------------------------------------

-- note: since all other buffer key bindings are dependent on the barbar plugin,
--       they're defined w/ the barbar plugin keymap

-- open splits
KM:bind({
  { '<leader>bh', ':split<CR>', { desc = 'open horizontal split' } },
  { '<leader>-', ':split<CR>', { desc = 'open horizontal split' } },
  { '<leader>|', ':vsplit<CR>', { desc = 'open vertical split' } },
})

-- spellcheck ------------------------------------------------------------------

KM:with({ desc_prefix = 'spelling: ' })
  :bind({
    { '<leader>da', 'zg', { desc = 'add word to dict' } },
    { '<leader>dr', 'zug', { desc = 'remove word from dict' } },
    ---@note: overridden in handled in keymap/plugins/telescope.lua
    -- FIXME: modifications to key mapper that added support for 'ignore' were totally fucked
    -- { '<leader>dr', 'zg',  { desc = 'show suggestions', ignore = true }},
  })
  :done()
