local KeyMapper = require 'utils.core.mapper'

local KM = KeyMapper.new({ nowait = true })

-- diffview --------------------------------------------------------------------

local function diffview(cmd)
  return function()
    Safe:call(vim.api.nvim_command, {}, 'Diffview' .. cmd)
  end
end

KM:with({ desc_prefix = 'diffview: ' })
  :bind({
    { '<leader>dv', diffview 'Open', { desc = 'open diff/merge view' } },
    { '<leader>dx', diffview 'Close', { desc = 'close diff/merge view' } },
    { '<leader>dh', diffview 'FileHistory', { desc = 'show all history' } },
    { '<leader>df', diffview 'FileHistory %', { desc = 'show file history' } },
    {
      '<leader>dS',
      diffview 'FileHistory -g --range=stash@{0}',
      { desc = 'open stash diff' },
    },
  })
  :done()

-- lazygit ---------------------------------------------------------------------

KM:with({ desc_prefix = 'lazygit: ' })
  :bind({
    { '<leader>go', ':LazyGit<CR>', { desc = 'open for cwd' } },
    { '<leader>gf', ':LazyGitFilter<CR>', { desc = 'view repo commits' } },
    {
      '<leader>gc',
      ':LazyGitCurrentFile<CR>',
      { desc = "open for current file's repo" },
    },
    { '<leader>gF', ':LazyGitFilterCurrentFile<CR>', { desc = 'view file commits' } },
  })
  :done()
