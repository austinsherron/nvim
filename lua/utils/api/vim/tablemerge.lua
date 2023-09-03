local Stream = require 'toolbox.extensions.stream'

local ternary = require('toolbox.core.bool').ternary


--- Basic wrapper around vim.tbl_deep_extend.
---
---@see vim.tbl_deep_extend
---@class TableMerge
local TableMerge = {}

local function tbl_deep_extend(merge_type, ...)
  return vim.tbl_deep_extend(merge_type, ...)
end


local function do_merge(merge_type, ...)
  local to_merge = Stream(Table.pack(...))
    :filter(Table.not_nil_or_empty)
    :collect()

  -- tbl_deep_extend requires at least two tables for merging; instead of failing, this
  -- will result in, "at worst", an empty table
  to_merge = ternary(#to_merge >= 2, to_merge, Table.concat({ to_merge, {{}, {}}}))
  return tbl_deep_extend(merge_type, Table.unpack(to_merge))
end


--- Merges tables from right to left, i.e.: on collision, values from rightmost table are
--- kept.
---
---@param ... table: tables to merge
---@return table: a table merged from the provided tables
function TableMerge.mergeleft(...)
  return do_merge('force', ...)
end


--- Merges tables from left to right, i.e.: on collision, values from leftmost table are
--- kept.
---
---@param ... table: tables to merge
---@return table: a table merged from the provided tables
function TableMerge.mergeright(...)
  return do_merge('keep', ...)
end

return TableMerge

