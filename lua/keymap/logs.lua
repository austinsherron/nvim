local KeyMapper = require 'utils.core.mapper'


local KM = KeyMapper.new({ desc_prefix = 'logs: ', nowait = true })

-- interactions ----------------------------------------------------------------

KM:bind({
  { '<leader>l', ':UserLogs vsplit<CR>', { desc = 'open in vsplit' }},
  { '<leader>L', ':UserLogs<CR>',        { desc = 'open'           }},
})

