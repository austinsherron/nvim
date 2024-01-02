local KeyMapper = require 'utils.core.mapper'


local KM = KeyMapper.new({ nowait = true })

-- diffview --------------------------------------------------------------------

KM:with({ desc_prefix = 'diffview: ' })
  :bind({
    { '<leader>dv', ':DiffviewOpen<CR>',          { desc = 'open diff/merge view'  }},
    { '<leader>dx', ':DiffviewClose<CR>',         { desc = 'close diff/merge view' }},
    { '<leader>dh', ':DiffviewFileHistory<CR>',   { desc = 'show all history'      }},
    { '<leader>df', ':DiffviewFileHistory %<CR>', { desc = 'show file history'     }},
  }):done()

-- lazygit ---------------------------------------------------------------------

KM:with({ desc_prefix = 'lazygit: ' })
  :bind({
    { '<leader>go', ':LazyGit<CR>',                  { desc = 'open for cwd'                 }},
    { '<leader>gf', ':LazyGitFilter<CR>',            { desc = 'view repo commits'            }},
    { '<leader>gc', ':LazyGitCurrentFile<CR>',       { desc = "open for current file's repo" }},
    { '<leader>gF', ':LazyGitFilterCurrentFile<CR>', { desc = 'view file commits'            }},
  }):done()

