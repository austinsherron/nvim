local KeyMapper = require 'utils.core.mapper'


local KM = KeyMapper.new({ desc_prefix = 'searchbox: ', nowait = true })

-- interactions ----------------------------------------------------------------

KM:bind({
  -- standard "incsearch": highlights first match as you type
  { '<leader>/', ':SearchBoxIncSearch<CR>',              { desc = 'incsearch'         }},
  { '<leader>?', ':SearchBoxIncSearch reverse=true<CR>', { desc = 'reverse incsearch' }},

  -- "match all" search: highlights all matches as you type and keeps them highlighted until cleared (below)
  { '<leader>,', ':SearchBoxMatchAll clear_matches=false<CR>', { desc = 'match all search'       }},
  { '<leader><', ':SearchBoxClear<CR>',                        { desc = 'clear match highlights' }},

  -- find and replace; the first asks for confirmation before each replace, the second just does it
  { '<leader>.', ':SearchBoxReplace confirm=menu<CR>', { desc = 'find and replace (confirm)'    }},
  { '<leader>>', ':SearchBoxReplace confirm=off<CR>',  { desc = 'find and replace (just do it)' }},
})

