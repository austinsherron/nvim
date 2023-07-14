local km = require 'nvim.lua.utils.core.mapper'


-- interactions ----------------------------------------------------------------

local options = {
    desc = 'lazy: open plugin mgr.',
    nowait = true,
    silent = true,
}

km.nnoremap('<leader>Z', ':Lazy<CR>', options)

