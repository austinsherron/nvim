
local MAX = 1000

--- Represents a plugin's "priority", i.e.: the order in which it is loaded; higher numbers
--- indicate a higher priority.
---
---@enum Priority
local Priority = {
  FIRST  = MAX - 0,
  SECOND = MAX - 1,
  THIRD  = MAX - 2,
  FOURTH = MAX - 3,
  FIFTH  = MAX - 4,
}

return Priority

