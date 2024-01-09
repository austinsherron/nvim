local KeyMapper = require 'utils.core.mapper'

local KM = KeyMapper.new({ desc_prefix = 'gitsigns: ', nowait = true })

local function blameline()
  local gs = package.loaded.gitsigns

  gs.blame_line({ full = true })
end

local function diffthis()
  local gs = package.loaded.gitsigns

  gs.diffthis '~'
end

local function prev_hunk()
  local gs = package.loaded.gitsigns

  gs.prev_hunk()
end

local function next_hunk()
  local gs = package.loaded.gitsigns

  gs.next_hunk()
end

-- TODO: revisit these mappings/descriptions
local function actions()
  local gs = package.loaded.gitsigns

  KM:bind({
    -- "hunk" ops: stage, unstage, etc. reset chunks of changes
    { '<leader>hs', ':Gitsigns stage_hunk<CR>', { desc = 'stage hunk' } },
    { '<leader>hr', ':Gitsigns reset_hunk<CR>', { desc = 'reset hunk' } },
    { '<leader>hp', gs.preview_hunk, { desc = 'preview hunk' } },
    { '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' } },

    -- buffer ops
    { '<leader>hS', gs.stage_buffer, { desc = 'stage buffer' } },
    { '<leader>hR', gs.reset_buffer, { desc = 'reset buffer' } },

    -- git blame ops
    { '<leader>hb', blameline, { desc = 'line git blame' } },
    { '<leader>ht', gs.toggle_current_line_blame, { desc = 'toggle line git blame' } },

    -- movement
    { '[g', prev_hunk, { desc = 'prev hunk' } },
    { ']g', next_hunk, { desc = 'next hunk' } },

    -- "changed" (diff/deleted) ops:
    { '<leader>hd', gs.diffthis, { desc = 'diff' } },
    { '<leader>hD', diffthis, { desc = 'diff ~' } },
    { '<leader>he', gs.toggle_deleted, { desc = 'toggle deleted' } },
  })
end

local function text_objects()
  KM:bind_one('ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select hunk' }, { 'o' })
end

--- Contains methods for configuring key bindings for gitsigns.
---
---@class Gitsigns
local Gitsigns = {}

--- Function that is called when gitsigns "attaches" to a buffer. Calls keymapping functions.
function Gitsigns.on_attach()
  actions()
  text_objects()
end

return Gitsigns
