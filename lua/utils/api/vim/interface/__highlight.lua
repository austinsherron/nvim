
--- A builder for highlight group definitions.
---
---@class Highlight
---@field name string: the highlight's identifier
---@field private hg table
local Highlight = {}
Highlight.__index = Highlight

--- Constructor
---
---@param name string: the highlight's identifier
---@return Highlight: a new instance
function Highlight.new(name)
  return setmetatable({ name = name, hg = {}}, Highlight)
end


--- Sets this instance's foreground color via the "fg" property.
---
---@param fg string: a string representation of a color, i.e.: a color name or a hex value
---@return Highlight: this instance
function Highlight:foreground(fg)
  self.hg.fg = fg
  return self
end


--- Sets this instance's background color via the "bg" property.
---
---@param bg string: a string representation of a color, i.e.: a color name or a hex value
---@return Highlight: this instance
function Highlight:background(bg)
  self.hg.bg = bg
  return self
end


--- Builds and returns the highlight definition.
---
---@return table: a highlight definition constructed from this instance
function Highlight:build()
  return self.hg
end

return Highlight

