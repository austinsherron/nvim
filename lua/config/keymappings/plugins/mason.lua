local km = require 'nvim.lua.utils.mapper'


-- interactions ----------------------------------------------------------------

local options = {
    desc = 'mason: open lsp mgr.',
    nowait = true,
    silent = true,
}

km.nnoremap('<leader>M', ':Mason<CR>', options)

