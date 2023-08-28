local KeyMapper = require 'utils.core.mapper'

local Notify = require 'notify'


local KM = KeyMapper.new({ nowait = true, silent = true })

-- alpha -----------------------------------------------------------------------

KM:with({ desc_prefix = 'alpha: ' })
  :bind({{ '<leader>0', ':Alpha<CR>', { desc = 'open startpage' }}})
  :done()

-- notify ----------------------------------------------------------------------

local function dismiss()
  Notify.dismiss({ pending = false, silent = false })
end

KM:with({ desc_prefix = 'notify: ' })
  :bind({
    { '<leader>3', ':Notifications<CR>', { desc = 'notification history'  }},
    { '<leader>~', dismiss,              { desc = 'dismiss notifications' }},
}):done()

-- sidebar ---------------------------------------------------------------------

KM:with({ desc_prefix = 'sidebar: ' })
  :bind({{ '<leader>2', ':SidebarNvimToggle<CR>', { desc = 'toggle' }}})
  :done()

-- undotree --------------------------------------------------------------------

KM:with({ desc_prefix = 'undotree: ' })
  :bind({{ '<leader>4', ':UndotreeToggle | UndotreeFocus<CR>', { desc = 'toggle' } }})
  :done()

