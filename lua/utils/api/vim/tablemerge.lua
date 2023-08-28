
--- Basic wrapper around vim.tbl_deep_extend.
---
---@see vim.tbl_deep_extend
---@class TableMerge
local TableMerge = {}

--- Merges tables from right to left, i.e.: on collision, values from rightmost table are
--- kept.
---
---@param ... tables: tables to merge
---@return table: a table merged from the provided tables
function TableMerge.mergeleft(...)
  return vim.tbl_deep_extend('force', ...)
end


--- Merges tables from left to right, i.e.: on collision, values from leftmost table are
--- kept.
---
---@param ... tables: tables to merge
---@return table: a table merged from the provided tables
function TableMerge.mergeright(...)
  return vim.tbl_deep_extend('keep', ...)
end

return TableMerge

