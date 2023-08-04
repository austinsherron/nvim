-- TODO: this file shouldn't be in keymap/plugins; figure out why it's not being read
--       keymap

local KM = require 'lua.utils.core.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
    return { desc = 'tabs: ' .. desc, nowait = true }
end

-- navigation ------------------------------------------------------------------

KM.nnoremap('<leader>tn', ':tabnext<CR>',     options('next'))
KM.nnoremap('<leader>tp', ':tabprevious<CR>', options('previous'))

-- core ops --------------------------------------------------------------------

KM.nnoremap('<leader>to', ':tabnew<CR>',   options('open'))
KM.nnoremap('<leader>tx', ':tabclose<CR>', options('close'))

-- misc. ops -------------------------------------------------------------------

KM.nnoremap('<leader>tl', ':tabs<CR>', options('list'))

