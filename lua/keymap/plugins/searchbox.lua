local km = require 'utils.core.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
  return { desc = 'searchbox: ' .. desc, nowait = true }
end

-- interactions ----------------------------------------------------------------

-- standard "incsearch": highlights first match as you type
km.nnoremap('<leader>/', ':SearchBoxIncSearch<CR>',              options('incsearch'))
km.nnoremap('<leader>?', ':SearchBoxIncSearch reverse=true<CR>', options('reverse incsearch'))

-- "match all" search: highlights all matches as you type and keeps them highlighted until cleared (below)
km.nnoremap('<leader>,', ':SearchBoxMatchAll clear_matches=false<CR>', options('match all search'))
km.nnoremap('<leader><', ':SearchBoxClear<CR>',                        options('clear match highlights'))

-- find and replace; the first asks for confirmation before each replace, the second just does it
km.nnoremap('<leader>.', ':SearchBoxReplace confirm=menu<CR>', options('find and replace (confirm)'))
km.nnoremap('<leader>>', ':SearchBoxReplace confirm=off<CR>',  options('find and replace (just do it)'))

