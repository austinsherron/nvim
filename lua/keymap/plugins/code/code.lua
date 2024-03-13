local KeyMapper = require 'utils.core.mapper'
local TFDoc = require 'plugins.config.code.tfdoc'
local View = require 'utils.api.vim.view'

local KM = KeyMapper.new({ nowait = true })

-- mason -----------------------------------------------------------------------

local function close_mason()
  View.close({ filetype = 'mason' })
end

KM:with({ desc_prefix = 'mason: ' })
  :bind({ { '<leader>M', ':Mason<CR>', { desc = 'open lsp mgr.' } } })
  :bind({ { '<leader>Mo', ':Mason<CR>', { desc = 'open lsp mgr.' } } })
  :bind({ { '<leader>Mx', close_mason, { desc = 'close lsp mgr.' } } })
  :done()

-- symbols-outline -------------------------------------------------------------

KM:with({ desc_prefix = 'symbols-outline: ' })
  :bind({ { '<leader>2', ':SymbolsOutline<CR>', { desc = 'toggle sidebar' } } })
  :done()

-- tf-doc ---------------------------------------------------------------------

KM:with({ desc_prefix = 'terraform doc: ' })
  :bind({
    { '<leader>tf', fmt(':%s<CR>', TFDoc.cmd_name()), { desc = 'open terraform docs' } },
  })
  :done()

-- treesj ---------------------------------------------------------------------

KM:with({ desc_prefix = 'TreeSJ: ' })
  :bind({ { '<leader>m', ':TSJToggle<CR>', { desc = 'toggle split/join block' } } })
  :done()
