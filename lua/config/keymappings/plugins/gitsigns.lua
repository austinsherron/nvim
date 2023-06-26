local km = require('nvim.lua.utils.mapper')


local function gitsigns_actions(gs)
  km.nnoremap('<leader>hs', ':Gitsigns stage_hunk<CR>')
  km.vnoremap('<leader>hs', ':Gitsigns stage_hunk<CR>')
  km.nnoremap('<leader>hr', ':Gitsigns reset_hunk<CR>')
  km.vnoremap('<leader>hr', ':Gitsigns reset_hunk<CR>')

  km.nnoremap('<leader>hS', gs.stage_buffer)
  km.nnoremap('<leader>hu', gs.undo_stage_hunk)
  km.nnoremap('<leader>hR', gs.reset_buffer)
  km.nnoremap('<leader>hp', gs.preview_hunk)
  km.nnoremap('<leader>hb', function() gs.blame_line{full=true} end)
  km.nnoremap('<leader>tb', gs.toggle_current_line_blame)
  km.nnoremap('<leader>hd', gs.diffthis)
  km.nnoremap('<leader>hD', function() gs.diffthis('~') end)
  km.nnoremap('<leader>td', gs.toggle_deleted)
end


local function gitsigns_text_objects()
  km.onoremmap('ih', ':<C-U>Gitsigns select_hunk<CR>')
  km.xnoremmap('ih', ':<C-U>Gitsigns select_hunk<CR>')
end


function gitsigns_on_attach()
  local gs = package.loaded.gitsigns

  return function(gs)
    gitsigns_actions(gs)
    gitsigns_text_objects(gs)
  end
end

