local Introspect = require 'toolbox.meta.introspect'
local Lazy       = require 'toolbox.utils.lazy'

local flash = Lazy.require 'flash'


--- Api wrapper around "jump" motion plugin.
---
---@class Jump
local Jump = {}
Jump.__index = Jump

--- Constructor
---
---@return Jump: a new instance
function Jump.new()
  return setmetatable({}, Jump)
end


local function directional_args(forward)
  forward = Bool.or_default(forward)

  return {
    search = {
      forward      = forward,
      multi_window = false,
      wrap         = false,
    },
  }
end

--- Initiate directional jump.
---
---@param forward boolean: if true, initiates a jump "ahead" of the cursor
function Jump:directional(forward)
  self['jump'](directional_args(forward))
end


--- Initiate linewise jump.
function Jump:to_line()
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

  self['jump'](args)
end


--- Initiate direction treesitter search.
---
---@param forward boolean: if true, initiates a jump "ahead" of the cursor
function Jump:ts_search(forward)
  self['treesitter_search'](directional_args(forward))
end


--- Custom index metamethod that returns a function that directly calls the jump plugin.
---
---@param k any: the name of a jump plugin function
---@return fun(...): any|nil: the jump plugin function that maps to k
function Jump:__index(k)
  local val = Introspect.get_from_metatable(self, k)

  if val ~= nil then
    return val
  end

  return flash[k]
end

return Jump.new()

