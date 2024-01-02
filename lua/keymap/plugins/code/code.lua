local KeyMapper = require 'utils.core.mapper'


local KM = KeyMapper.new({ nowait = true })

-- aerial ----------------------------------------------------------------------

-- NOTE: disabled while I try out symbols-outline

-- KM:with({ desc_prefix = 'aerial: ' })
--   :bind({
--   { '<leader>a', ':AerialToggle<CR>',    { desc = 'toggle sidebar' }},
--   { '<leader>A', ':AerialNavToggle<CR>', { desc = 'toggle popup'   }},
-- }):done()

-- mason -----------------------------------------------------------------------

KM:with({ desc_prefix = 'mason: ' })
  :bind({{ '<leader>M', ':Mason<CR>', { desc = 'open lsp mgr.' }}})
  :done()

-- sniprun ---------------------------------------------------------------------

KM:with({ desc_prefix = 'sniprun: ' })
  :bind({{ '<leader>R', ':SnipRun<CR>', { desc = 'run' }, { 'v' }}})
  :done()

-- symbols-outline -------------------------------------------------------------

KM:with({ desc_prefix = 'symbols-outline: ' })
  :bind({{ '<leader>a', ':SymbolsOutline<CR>', { desc = 'toggle sidebar' }}})
  :done()

-- treesj ---------------------------------------------------------------------

KM:with({ desc_prefix = 'TreeSJ: ' })
  :bind({{ '<leader>m', ':TSJToggle<CR>', { desc = 'toggle split/join block' } }})
  :done()

