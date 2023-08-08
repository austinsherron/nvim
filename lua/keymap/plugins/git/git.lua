local KM = require 'lua.utils.core.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function make_options(plugin)
  return function(desc)
    return { desc = plugin .. ': ' .. desc, nowait = true }
  end
end

local options

-- diffview --------------------------------------------------------------------

options = make_options('diffview')

KM.nnoremap('<leader>dv', ':DiffviewOpen<CR>',          options('open diff/merge view'))
KM.nnoremap('<leader>dx', ':DiffviewClose<CR>',         options('close diff/merge view'))
KM.nnoremap('<leader>dh', ':DiffviewFileHistory<CR>',   options('show all history'))
KM.nnoremap('<leader>df', ':DiffviewFileHistory %<CR>', options('show file history'))

-- lazygit ---------------------------------------------------------------------

options = make_options('lazygit')

KM.nnoremap('<leader>go', ':LazyGit<CR>',                  options('open for cwd'))
KM.nnoremap('<leader>gf', ':LazyGitFilter<CR>',            options('view repo commits'))
KM.nnoremap('<leader>gc', ':LazyGitCurrentFile<CR>',       options("open for current file's repo"))
KM.nnoremap('<leader>gF', ':LazyGitFilterCurrentFile<CR>', options('view file commits'))

-- neogit ----------------------------------------------------------------------

KM.nnoremap('<leader>G', ':Neogit<CR>', { desc = 'neogit: open' })

