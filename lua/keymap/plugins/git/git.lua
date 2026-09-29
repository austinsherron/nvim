local Interaction = require 'utils.api.vim.interaction'
local KeyMapper = require 'utils.core.mapper'

local KM = KeyMapper.new({ nowait = true })

-- codediff -------------------------------------------------------------------

---@param cmd string: args to pass to the "CodeDiff" command
---@return function: a function that runs "CodeDiff" w/ the provided args
local function codediff(cmd)
  return function()
    Safe.call(vim.api.nvim_command, {}, ('CodeDiff %s'):format(cmd))
  end
end

local function something()
  return function()
    local toreview, _ = Interaction.input('CodeDiff ', { default = '', nofmt = true })
    return codediff(toreview)()
  end
end

KM:with({ desc_prefix = 'codediff: ' })
  :bind({
    { '<leader>dv', codediff '', { desc = 'review working tree' } },
    { '<leader>dm', codediff 'master', { desc = 'review against master' } },
    { '<leader>dh', codediff 'history', { desc = 'browse commit history' } },
    { '<leader>df', codediff 'history %', { desc = 'browse current file history' } },
    { '<leader>dS', codediff 'stash@{0}', { desc = 'review stash@{0}' } },
    { '<leader>dA', something(), { desc = 'review from user input' } },
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
