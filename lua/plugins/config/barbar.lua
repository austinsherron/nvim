
--- Contains functions for configuring barbar.
--
---@class Barbar
local Barbar = {}

---@return table: a table that contains configuration values for the barbar plugin
function Barbar.opts()
  return {
    -- visual
    animation = true,
    clickable = false,

    -- behavior
    focus_on_close = 'previous',
    no_name_title  = 'unnamed'
  }
end

return Barbar

