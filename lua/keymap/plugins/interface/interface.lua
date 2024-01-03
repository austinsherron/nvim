local Window    = require 'utils.api.vim.window'
local KeyMapper = require 'utils.core.mapper'

local HintFmttr = require('plugins.extensions.interface.hydra').HintFormatter

local Dir = Window.ResizeDirection

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

-- smart-splits ----------------------------------------------------------------

-- resize
KM:with_hydra({ name = '⬅⬆⬇➡ Resize', body = '<leader>R' })
  :with({ hint = HintFmttr.middle_right_1() })
  :bind({
    { 'j', function() Window.resize(Dir.DOWN) end,  { desc = 'resize down'       }},
    { 'k', function() Window.resize(Dir.UP) end,    { desc = 'resize up'         }},
    { 'h', function() Window.resize(Dir.LEFT) end,  { desc = 'resize left'       }},
    { 'l', function() Window.resize(Dir.RIGHT) end, { desc = 'resize right'      }},
    { 'J', function() Window.swap(Dir.DOWN) end,    { desc = 'swap buffer down'  }},
    { 'K', function() Window.swap(Dir.UP) end,      { desc = 'swap buffer up'    }},
    { 'H', function() Window.swap(Dir.LEFT) end,    { desc = 'swap buffer left'  }},
    { 'L', function() Window.swap(Dir.RIGHT) end,   { desc = 'swap buffer right' }},
  }):done({ purge = 'current' })

-- undotree --------------------------------------------------------------------

KM:with({ desc_prefix = 'undotree: ' })
  :bind({{ '<leader>4', ':UndotreeToggle | UndotreeFocus<CR>', { desc = 'toggle' } }})
  :done()

