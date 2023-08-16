local KM = require 'utils.core.mapper'

local Notify = require 'notify'


local function make_options(plugin)
  return function(desc)
    return { desc = plugin .. ': ' .. desc, nowait = true, silent = true }
  end
end

local options

-- alpha -----------------------------------------------------------------------

options = make_options('alpha')

KM.nnoremap('<leader>0', ':Alpha<CR>', options('open startpage'))

-- notify ----------------------------------------------------------------------

local function dismiss()
  Notify.dismiss({ pending = false, silent = false })
end

options = make_options('notify')

KM.nnoremap('<leader>3', ':Notifications<CR>', options('notification history'))
KM.nnoremap('<leader>~', dismiss,              options('dismiss notifications'))

-- sidebar ---------------------------------------------------------------------

options = make_options('sidebar')

KM.nnoremap('<leader>2', ':SidebarNvimToggle<CR>', options('toggle'))

-- undotree --------------------------------------------------------------------

options = make_options('undotree')

KM.nnoremap('<leader>4', ':UndotreeToggle | UndotreeFocus<CR>', options('toggle'))

