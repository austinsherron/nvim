local Num       = require 'toolbox.core.num'
local MenuFmttr = require 'utils.plugins.menuformatter'


---@alias HintMenuFormatter fun(b: Binding[], name: string|nil): string
---@alias HydraHint { fmttr: HintMenuFormatter, position: string, border: string, type: string }

--- Utility for formatting hydra hints. See :h hydra-config.hint.
---
---@class HintFormatter
---@field [any] any
local HintFormatter = {}
HintFormatter.__index = HintFormatter

--- Constructor
---
---@return HintFormatter: a new instance
function HintFormatter.new()
  return setmetatable({}, HintFormatter)
end


local function make_fmt(columns)
  return function(bindings, name)
    return MenuFmttr.format(bindings, columns, name)
  end
end


local function parse_name(k)
  local parts = String.split(k, '_')

  if #parts < 2 then
    Err.raise('Hydra.HintFormatter: function name should consist of 2/3 tokens separated by "_" (%s)', k)
  end

  if not Num.isstrint(Array.index(parts, -1))  then
    Err.raise('Hydra.HintFormatter: the function name token after the last "_" must be an int (%s)', k)
  end

  -- get the colnums value from the name; it's the value after the last "_"
  local colnums = Num.as(Array.index(parts, -1))
  -- join the rest of the array entries by "-" to get the position
  local position = String.join(Array.slice(parts, 1, -1), '-')

  return position, colnums
end


local function make_hint_opts(position, cols)
  return function() return
    {
      border   = 'rounded',
      fmttr    = make_fmt(cols),
      position = position,
      type     = 'window',
    }
  end
end


--- Custom index metamethod that expects function name keys of the following form:
---
---   [hydra.nvim hint position]_[number of columns in hint format]
---
--- More concretely:
---
---   middle_right_1, bottom_3, middle_4
---
--- The function name is parsed and used to construct hydra hint config, as well as a menu
--- formatter used by KeyMapper to format hydra binding hints.
---
---@param k string: a function name in the aforementioned format
---@return fun(): HydraHint a function that returns config for a hydra hint menu; all but
--- fmttr is native to hydra (see :h hydra-config.hint)
function HintFormatter:__index(k)
  local pos, cols = parse_name(k)
  return make_hint_opts(pos, cols)
end

return {
  HintFormatter = HintFormatter.new(),
}

