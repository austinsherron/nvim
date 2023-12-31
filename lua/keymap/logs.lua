local KeyMapper = require 'utils.core.mapper'


local KM = KeyMapper.new({ desc_prefix = 'logs: ', nowait = true })

-- interactions ----------------------------------------------------------------

KM:bind({
  { '<leader>lf', ':UserLogs<CR>',        { desc = 'open'           }},
  { '<leader>lh', ':UserLogs split<CR>',  { desc = 'open in split'  }},
  { '<leader>lv', ':UserLogs vsplit<CR>', { desc = 'open in vsplit' }},
})

