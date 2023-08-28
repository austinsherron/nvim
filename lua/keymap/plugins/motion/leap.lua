-- TODO: remove this code if I decide to permanently adopt flash instead of leap

local KeyMapper = require 'utils.core.mapper'


local KM = KeyMapper.new({
  desc_prefix = 'leap: ',
  nowait      = true,
  silent      = true,
})

local function leap(backward)
  require('leap').leap({
    opts = {
      backward     = backward,
      inclusive_op = true,
    }
  })
end


local function leap_forward()
  leap(false)
end


-- FIXME: doesn't seem to work (leaps forward)
local function leap_backward()
  leap(true)
end

--- Contains methods for invoking/interacting w/ leap.nvim.
---
---@class LeapKM
local LeapKM = {}

--- Invokes bi-directional leap.
function LeapKM.bidirectional_leap()
  local current_window = vim.fn.win_getid()
  require('leap').leap({ target_windows = { current_window } })
end


--- Returns the key used to invoke bi-directional leap.
---
--- Note: this is exposed as a function in order to centralize this configuration in case
--- of future updates, as it's used in multiple places.
---
---@return string: the key used to invoke bi-directional leap
function LeapKM.bidirectional_leap_key()
  return 'q'
end


local function add_defaults()
  require('leap').add_default_mappings()
end


local function add_repeats()
  require('leap').add_repeat_mappings(';', ',', {
    relative_directions = true,
    modes               = { 'n', 'x', 'o' },
  })
end

-- interactions ----------------------------------------------------------------

--- Creates key bindings for leap.nvim.
---
--- Note: exposed as a function instead of called on require to avoid adding keymap when
--- files import Leap (i.e.: nvimtree, at the time of writing). At the time of writing, this
--- function is invoked from leap.nvim's plugin config function.
---
---@param should_add_defaults boolean?: if true, default key bindings will be added; defaults
--- to false
---@param should_add_repeats boolean?: if true, key bindings for "repeat" motions will be
--  added (think `f` -> `,`|`;`); defaults to false
function LeapKM.add_keymap(should_add_defaults, should_add_repeats)
  should_add_defaults = should_add_defaults or false
  should_add_repeats = should_add_repeats or false

  KM:bind({
    { '>', leap_forward,                 { desc = 'forward'  }},
  -- FIXME: this works, but we're not able to pass `inclusive_op`, which means the jump
  --        misses by a few chars; we can't use the above format, because it just straight
  --        up doesn't work (jumps forward)
    { '<', '<Plug>(leap-backward-till)', { desc = 'backward' }},

    { LeapKM.bidirectional_leap_key(), LeapKM.bidirectional_leap, { desc = 'bi-directional' }},
  })

  if should_add_defaults then
    add_defaults()
  end

  if should_add_repeats then
    add_repeats()
  end
end

return LeapKM

