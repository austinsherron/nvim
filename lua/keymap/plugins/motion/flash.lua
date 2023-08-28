local KeyMapper = require 'utils.core.mapper'


local KM = KeyMapper.new({ desc_prefix = 'flash: ', nowait = true })

local function flash(cmd, args)
  return function()
    return require('flash')[cmd](args)
  end
end


local function directional(forward)
  local args = {
    search = {
      forward      = forward,
      multi_window = false,
      wrap         = false,
    },
  }
  return flash('jump', args)
end


local function to_line()
  local args = {
    label   = {
      after = { 0, 0 },
    },
    pattern = '^',
    search  = {
      max_length = 0,
      mode       = 'search',
    },
  }
  return flash('jump', args)
end

--- Contains functions for adding key-bindings for the flash plugin.
---
---@class FlashKM
local FlashKM = {}

--- Adds key-bindings for bi-directional jump.
---
---@note: this binding exists as a standalone function because it's used in multiple
--- distinct locations (at the time of writing, nvim-tree)
function FlashKM.jump()
  KM:bind({{ 'q', flash('jump'), { desc = 'jump' }, { 'n', 'x', 'o' }}})
end

-- keymap ----------------------------------------------------------------------

--- Creates key bindings for flash.nvim.
---
--- Note: exposed as a function instead of called on require to avoid adding keymap when
--- files import FlashKM (i.e.: nvimtree, at the time of writing). At the time of writing, this
--- function is invoked from flash.nvim's plugin config function.
---
function FlashKM.add_keymap()
  FlashKM.jump()

  KM:bind({
    { ';',     directional(true),          { desc = 'jump forward'              }, { 'n', 'x'      }},
    { '"',     directional(false),         { desc = 'jump backward'             }, { 'n', 'x'      }},
    { ',',     to_line(),                  { desc = 'jump to line'              }, { 'n', 'x'      }},
    { 'Q',     flash('treesitter'),        { desc = 'jump to treesitter symbol' }, { 'n', 'x', 'o' }},
    { 'T',     flash('treesitter_search'), { desc = 'treesitter search'         }, { 'x', 'o'      }},
    { '<M-s>', flash('toggle'),            { desc = 'toggle flash search'       }},
  })
end

return FlashKM

