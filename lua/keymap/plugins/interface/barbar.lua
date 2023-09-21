local KeyMapper = require 'utils.core.mapper'


local KM = KeyMapper.new({ desc_prefix = 'buffers: ', nowait = true })

-- navigation ------------------------------------------------------------------

-- sequential --

-- next
KM:bind({
  { '<leader>n', ':BufferNext<CR>', { desc = 'next' }},
  { '<M-]>',     ':BufferNext<CR>', { desc = 'next' }},
})

-- prev
KM:bind({
  { '<leader>p', ':BufferPrevious<CR>', { desc = 'previous' }},
  { '<M-[>',     ':BufferPrevious<CR>', { desc = 'previous' }},
})

-- jump to... --

-- w/ leader
KM:bind({
  { '<leader>b1', ':BufferGoto 1<CR>', { desc = 'go to 1'    }},
  { '<leader>b2', ':BufferGoto 2<CR>', { desc = 'go to 2'    }},
  { '<leader>b3', ':BufferGoto 3<CR>', { desc = 'go to 3'    }},
  { '<leader>b4', ':BufferGoto 4<CR>', { desc = 'go to 4'    }},
  { '<leader>b5', ':BufferGoto 5<CR>', { desc = 'go to 5'    }},
  { '<leader>b6', ':BufferGoto 6<CR>', { desc = 'go to 6'    }},
  { '<leader>b7', ':BufferGoto 7<CR>', { desc = 'go to 7'    }},
  { '<leader>b8', ':BufferGoto 8<CR>', { desc = 'go to 8'    }},
  { '<leader>b9', ':BufferGoto 9<CR>', { desc = 'go to 9'    }},
  { '<leader>b0', ':BufferLast<CR>',   { desc = 'go to last' }},
  { '<leader>bg', ':BufferPick<CR>',   { desc = 'go to...'   }},
})

-- with meta (i.e.: alt/option)
KM:bind({
  { '<M-1>', ':BufferGoto 1<CR>', { desc = 'go to 1'    }},
  { '<M-2>', ':BufferGoto 2<CR>', { desc = 'go to 2'    }},
  { '<M-3>', ':BufferGoto 3<CR>', { desc = 'go to 3'    }},
  { '<M-4>', ':BufferGoto 4<CR>', { desc = 'go to 4'    }},
  { '<M-5>', ':BufferGoto 5<CR>', { desc = 'go to 5'    }},
  { '<M-6>', ':BufferGoto 6<CR>', { desc = 'go to 6'    }},
  { '<M-7>', ':BufferGoto 7<CR>', { desc = 'go to 7'    }},
  { '<M-8>', ':BufferGoto 8<CR>', { desc = 'go to 8'    }},
  { '<M-9>', ':BufferGoto 9<CR>', { desc = 'go to 9'    }},
  { '<M-0>', ':BufferLast<CR>',   { desc = 'go to last' }},
  { '<M-p>', ':BufferPick<CR>',   { desc = 'go to...'   }},
})

-- core ops --------------------------------------------------------------------

-- close/delete --

-- current
KM:bind({
  { '<leader>x', ':BufferClose<CR>', { desc = 'close' }},
  { '<M-x>',     ':BufferClose<CR>', { desc = 'close' }},
  { '<M-w>',     ':BufferClose<CR>', { desc = 'close' }},
})

-- all but current
KM:bind({
  { '<leader>X', ':BufferCloseAllButCurrent<CR>', { desc = 'close all but current' }},
  { '<S-M-X>',   ':BufferCloseAllButCurrent<CR>', { desc = 'close all but current' }},
})

-- restore
KM:bind({
  { '<leader>br', ':BufferRestore<CR>', { desc = 'restore' }},
  { '<M-S-B>',    ':BufferRestore<CR>', { desc = 'restore' }},
  { '<M-S-T>',    ':BufferRestore<CR>', { desc = 'restore' }},
})

-- misc ops --------------------------------------------------------------------

-- pin
KM:bind_one('<leader>bp', ':BufferPin<CR>', { desc = 'pin' })

-- reorder
KM:bind({
  { '<leader>bd', ':BufferOrderByDirectory<CR>',    { desc = 'order by dir'  }},
  { '<leader>b#', ':BufferOrderByBufferNumber<CR>', { desc = 'order by #'    }},
  { '<leader>bl', ':BufferOrderByLanguage<CR>',     { desc = 'order by lang' }},
})

