local km = require 'nvim.lua.utils.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
    return { desc = 'gitsigns: ' .. desc, nowait = true }
end


local function blameline()
    local gs = package.loaded.gitsigns

    gs.blame_line { full = true }
end


local function diffthis()
    local gs = package.loaded.gitsigns

    gs.diffthis('~')
end

-- TODO: revisit these mappings/descriptions once the gitsigns on_attach issue
--       is resolved

local function actions()
    local gs = package.loaded.gitsigns

    km.nnoremap('<leader>hs', ':Gitsigns stage_hunk<CR>', options('stage hunk'))
    km.nnoremap('<leader>hr', ':Gitsigns reset_hunk<CR>', options('reset hunk'))
    km.nnoremap('<leader>hp', gs.preview_hunk,            options('preview hunk'))
    km.nnoremap('<leader>hu', gs.undo_stage_hunk,         options('undo stage hunk'))

    km.nnoremap('<leader>hS', gs.stage_buffer, options('stage buffer'))
    km.nnoremap('<leader>hR', gs.reset_buffer, options('reset buffer'))

    km.nnoremap('<leader>hb', blameline,                    options('line git blame'))
    km.nnoremap('<leader>lb', gs.toggle_current_line_blame, options('toggle line git blame'))

    km.nnoremap('<leader>hd', gs.diffthis,       options('diff'))
    km.nnoremap('<leader>hD', diffthis,          options('diff ~'))
    km.nnoremap('<leader>sd', gs.toggle_deleted, options('toggle deleted'))
end


local function text_objects()
    km.onoremap('ih', ':<C-U>Gitsigns select_hunk<CR>', options('select hunk'))
end


local Gs = {}

function Gs.on_attach()
    actions()
    text_objects()
end

return Gs

