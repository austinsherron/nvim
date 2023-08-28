local KeyMapper = require 'utils.core.mapper'


local KM = KeyMapper.new({ nowait = true })

-- aerial ----------------------------------------------------------------------

KM:with({ desc_prefix = 'aerial: ' })
  :bind({
  { '<leader>a', ':AerialToggle<CR>',    { desc = 'toggle sidebar' }},
  { '<leader>A', ':AerialNavToggle<CR>', { desc = 'toggle popup'   }},
}):done()

-- -- mason -----------------------------------------------------------------------

KM:with({ desc_prefix = 'mason: ' })
  :bind({{ '<leader>M', ':Mason<CR>', { desc = 'open lsp mgr.' }}})
  :done()

-- -- sniprun ---------------------------------------------------------------------

KM:with({ desc_prefix = 'sniprun: ' })
  :bind({{ '<leader>R', ':SnipRun<CR>', { desc = 'run' }, { 'v' }}})
  :done()

-- -- treesj ---------------------------------------------------------------------

KM:with({ desc_prefix = 'TreeSJ: ' })
  :bind({{ '<leader>m', ':TSJToggle<CR>', { desc = 'toggle split/join block' } }})
  :done()

