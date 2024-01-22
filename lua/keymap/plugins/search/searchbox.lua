local KeyMapper = require 'utils.core.mapper'
local Search = require 'utils.api.search'

local KM = KeyMapper.new({ desc_prefix = 'searchbox: ', nowait = true })

-- interactions ----------------------------------------------------------------

local function call(func, opts)
  return function()
    Search[func](opts or {})
  end
end

KM:bind({
  -- standard "incsearch": highlights first match as you type
  { '/', call 'incsearch', { desc = 'incsearch' }, { 'n', 'v' } },
  {
    '?',
    call('incsearch', { reverse = true }),
    { desc = 'reverse incsearch' },
    { 'n', 'v' },
  },

  -- "match all" search: highlights all matches as you type and keeps them highlighted until cleared (below)
  { '<leader>/', call 'match_all', { desc = 'match all search' }, { 'n', 'v' } },
  {
    '<leader>?',
    call('match_all', { reverse = true }),
    { desc = 'reverse match all search' },
    { 'n', 'v' },
  },
  { '<leader>hx', call 'clear', { desc = 'clear match highlights' } },

  -- find and replace; the first asks for confirmation before each replace, the second just does it
  { '<leader>.', call 'replace', { desc = 'find and replace (confirm)' }, { 'n', 'v' } },
  {
    '<leader>>',
    call('replace', { force = true }),
    { desc = 'find and replace (just do it)' },
    { 'n', 'v' },
  },
})
