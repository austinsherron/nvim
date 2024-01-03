
--- Contains utilities for interacting w/ (n)vim tabs.
---
---@class Tab
local Tab = {}

---@return integer: the id of the current tab, i.e.: where the cursor is
function Tab.current()
  return vim.api.nvim_get_current_tabpage()
end


--- Gets the windows associated w/ the provided tab.
---
--- @param tabnr integer|nil: optional, defaults to the current tab; the id of the tab to
---@return integer[]: an array of ids of windows associated w/ the provided tab
function Tab.windows(tabnr)
  tabnr = tabnr or Tab.current()
  return vim.api.nvim_tabpage_list_wins(tabnr)
end


--- Opens a new tab.
function Tab.open()
  vim.api.nvim_command('tabnew')
end


--- Closes the tab w/ id tabnr.
---
---@param tabnr integer|nil: optional, defaults to the current tab; the id of the tab to
--- close
function Tab.close(tabnr)
  tabnr = tabnr or Tab.current()
  vim.api.nvim_command('tabclose ' .. tabnr)
end

return Tab

