local KeyMapper = require 'utils.core.mapper'


local KM = KeyMapper.new({ nowait = true })

-- nvim-tmux nav ---------------------------------------------------------------

KM:with({ desc_prefix = 'nvim-tmux: ' })
  :bind({
    { '<silent><C-h>', ':NvimTmuxNavigateLeft<CR>',  { desc = 'mv left'  }},
    { '<silent><C-j>', ':NvimTmuxNavigateDown<CR>',  { desc = 'mv down'  }},
    { '<silent><C-k>', ':NvimTmuxNavigateUp<CR>',    { desc = 'mv up'    }},
    { '<silent><C-l>', ':NvimTmuxNavigateRight<CR>', { desc = 'mv right' }},
}):done()

