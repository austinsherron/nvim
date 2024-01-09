local Editor = require 'utils.api.vim.editor'
local TMerge = require 'utils.api.vim.tablemerge'

local Mode = Editor.Mode

local searchbox = require 'searchbox'

DEFAULT_OPTS = {
  case_sensitive = false,
}

MATCH_OPTS = function(reverse)
  local title = ternary(reverse == true, ' (Reverse)', '')
  return {
    title = 'Match All Search' .. title,
    clear_matches = false,
    reverse = reverse,
  }
end

REPLACE_OPTS = function(force)
  local title = ternary(force == true, 'Force', 'Safe')
  return {
    title = fmt('Find/Replace (%s)', title),
    case_sensitive = true,
  }
end

--- Type definition for search opts.
---
--- WARN: this type def is partially based on searchbox plugin impl.
---
---@class SearchOpts
---@field reverse boolean|nil: see :h searchbox-search-options for details
---@field exact boolean|nil: see :h searchbox-search-options for details
---@field show_matches boolean|nil: see :h searchbox-search-options for details
---@field clear_matches boolean|nil: optional, defaults to false; see :h
--- searchbox-search-options for details
---@field case_sensitive boolean|nil: optional, defaults to false for search, true for
--- replace; if true, search is case sensitive
---@field force boolean|nil: optional, defaults to false; only used for replace; if true,
--- replacement happens w/o asking for confirmation before each replace operation

--- Api wrapper for search plugin.
---
---@class Search
local Search = {}

local function api()
  return searchbox
end

local function searchopts(opts, type_opts)
  opts = opts or {}

  local special, rest = Table.split(opts, { 'force', 'case_sensitive' })
  local confirm = ternary(special.force == true, 'off', 'menu')

  local modifier = ternary(special.case_sensitive == true, 'case-sensitive', 'ignore-case')

  special = {
    confirm = confirm,
    modifier = modifier,
    visual_mode = Editor.is_mode(Mode.VISUAL),
  }

  return TMerge.mergeright(rest, special, type_opts or {}, DEFAULT_OPTS)
end

--- Performs standard incsearch.
---
---@param opts SearchOpts|nil: parameterizes search
function Search.incsearch(opts)
  opts = searchopts(opts)
  api().incsearch(opts)
end

--- Performs search that highlights matches as the query is typed.
---
--- Note: highlights are persistent by default. Use Search.clear to clear highlights.
---
---@param opts SearchOpts|nil: parameterizes search
function Search.match_all(opts)
  opts = opts or {}
  opts = searchopts(opts, MATCH_OPTS(opts.reverse))

  api().match_all(opts)
end

--- Finds and replaces search text in the current buffer.
---
---@param opts SearchOpts|nil: parameterizes search and replacement
function Search.replace(opts)
  opts = opts or {}
  opts = searchopts(opts, REPLACE_OPTS(opts.force))

  api().replace(opts)
end

--- Clears search highlighting.
function Search.clear()
  api().clear_matches()
  vim.cmd 'noh'
end

return Search
