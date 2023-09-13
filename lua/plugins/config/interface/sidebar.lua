
--- Contains functions for configuring the sidebar plugin.
---
---@class Sidebar
local Sidebar = {}

local function buffers_section()
  return {
    icon              = '',
    ignore_not_loaded = false,
    ignore_terminal   = true,
    ignored_buffers   = {},
    show_numbers      = true,
    sorting           = 'id',
  }
end


local function todo_section()
  return {
    icon             = '',
    ignored_paths    = { '~' },
    initially_closed = false,
  }
end


---@return table: a table that contains configuration values for the sidebar plugin
function Sidebar.opts()
  return {
    sections = { 'datetime', 'buffers', 'todos', 'diagnostics' },
    buffers  = buffers_section(),
    todos    = todo_section(),
  }
end

return Sidebar

