
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


--- Contains utilities for interacting w/ nvim ui elements.
---
---@class Interface
local Interface = {}

---@note: so Highlight is publicly accessible
Interface.Highlight = Highlight

--- Sets a highlight group w/ the provided name on the provided buffer.
---
---@param highlight Highlight: the highlight's definition
---@param bufnr integer|nil: optional, defaults to 0 (global); the id of the buffer on
--- which to set the highlight
function Interface.set_highlight(highlight, bufnr)
  bufnr = bufnr or 0

  local hg = highlight:build()
  vim.api.nvim_set_hl(bufnr, highlight.name, hg)

  Debug('Highlight=%s created for bufnr=%s; def=%s', { highlight.name, bufnr, hg })
end

return Interface

