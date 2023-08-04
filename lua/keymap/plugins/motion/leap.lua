local KM = require 'lua.utils.core.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
  return { desc = 'leap: ' .. desc, nowait = true, silent = true }
end


local function leap(backward)
  require('leap').leap({
    opts = {
      inclusive_op = true,
      backward     = backward,
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
---@class Leap
local Leap = {}

--- Invokes bi-directional leap.
function Leap.bidirectional_leap()
  local current_window = vim.fn.win_getid()
  require('leap').leap({ target_windows = { current_window } })
end


--- Returns the key used to invoke bi-directional leap.
---
--- Note: this is exposed as a function in order to centralize this configuration in case
--- of future updates, as it's used in multiple places.
---
---@return string: the key used to invoke bi-directional leap
function Leap.bidirectional_leap_key()
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
function Leap.add_keymap(should_add_defaults, should_add_repeats)
  should_add_defaults = should_add_defaults or false
  should_add_repeats = should_add_repeats or false

  KM.nnoremap('>', leap_forward,                 options('forward'))
-- FIXME: this works, but we're not able to pass `inclusive_op`, which means the jump
--        misses by a few chars; we can't use the above format, because it just straight
--        up doesn't work (jumps forward)
  KM.nnoremap('<', '<Plug>(leap-backward-till)', options('backward'))

  KM.nnoremap(Leap.bidirectional_leap_key(), Leap.bidirectional_leap, options('bi-directional'))

  if should_add_defaults then
    add_defaults()
  end

  if should_add_repeats then
    add_repeats()
  end
end

return Leap

