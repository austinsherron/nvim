local KeyMapper = require 'utils.core.mapper'


local KM = KeyMapper.new({ desc_prefix = 'tabs: ', nowait = true })

-- navigation ------------------------------------------------------------------

KM:bind({
  { '<leader>tn', ':tabnext<CR>',     { desc = 'next'     }},
  { '<leader>tp', ':tabprevious<CR>', { desc = 'previous' }},
})

-- core ops --------------------------------------------------------------------

KM:bind({
  { '<leader>to', ':tabnew<CR>',   { desc = 'open'  }},
  { '<leader>tx', ':tabclose<CR>', { desc = 'close' }},
})

-- misc ops --------------------------------------------------------------------

KM:bind_one('<leader>tl', ':tabs<CR>', { desc = 'list' })

