local KeyMapper = require 'utils.core.mapper'

local notify = require 'notify'
local todo = require 'todo-comments'

local KM = KeyMapper.new({ nowait = true })

-- alpha -----------------------------------------------------------------------

KM:with({ desc_prefix = 'alpha: ' }):bind({ { '<leader>0', ':Alpha<CR>', { desc = 'open startpage' } } }):done()

-- notify ----------------------------------------------------------------------

local function dismiss()
  notify.dismiss({ pending = false, silent = false })
end

KM:with({ desc_prefix = 'notify: ' })
  :bind({
    { '<leader>3', ':Notifications<CR>', { desc = 'notification history' } },
    { '<leader>~', dismiss, { desc = 'dismiss notifications' } },
  })
  :done()

-- todo-comments ---------------------------------------------------------------

KM:with({ desc_prefix = 'todo-comments: ' })
  :bind({
    { '[c', todo.jump_prev, { desc = 'Prev todo-comment' } },
    { ']c', todo.jump_next, { desc = 'Next todo-comment' } },
  })
  :done()

-- undotree --------------------------------------------------------------------

KM:with({ desc_prefix = 'undotree: ' })
  :bind({ { '<leader>4', ':UndotreeToggle | UndotreeFocus<CR>', { desc = 'toggle' } } })
  :done()
