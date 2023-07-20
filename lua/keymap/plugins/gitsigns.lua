local KM = require 'utils.core.mapper'


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


-- TODO: revisit these mappings/descriptions
local function actions()
  local gs = package.loaded.gitsigns

  -- "hunk" ops: stage, unstage, etc. reset chunks of changes
  KM.nnoremap('<leader>hs', ':Gitsigns stage_hunk<CR>', options('stage hunk'))
  KM.nnoremap('<leader>hr', ':Gitsigns reset_hunk<CR>', options('reset hunk'))
  KM.nnoremap('<leader>hp', gs.preview_hunk, options('preview hunk'))
  KM.nnoremap('<leader>hu', gs.undo_stage_hunk, options('undo stage hunk'))

  -- buffer ops
  KM.nnoremap('<leader>hS', gs.stage_buffer, options('stage buffer'))
  KM.nnoremap('<leader>hR', gs.reset_buffer, options('reset buffer'))

  -- git blame ops
  KM.nnoremap('<leader>hb', blameline, options('line git blame'))
  KM.nnoremap('<leader>ht', gs.toggle_current_line_blame, options('toggle line git blame'))

  -- "changed" (diff/deleted) ops:
  KM.nnoremap('<leader>hd', gs.diffthis, options('diff'))
  KM.nnoremap('<leader>hD', diffthis, options('diff ~'))
  KM.nnoremap('<leader>he', gs.toggle_deleted, options('toggle deleted'))
end


local function text_objects()
  KM.onoremap('ih', ':<C-U>Gitsigns select_hunk<CR>', options('select hunk'))
end

--- Contains methods for configuring key bindings for gitsigns.
--
---@class Gitsigns
local Gitsigns = {}

--- Function that is called when gitsigns "attaches" to a buffer. Calls keymapping functions.
function Gitsigns.on_attach()
  actions()
  text_objects()
end

return Gitsigns

