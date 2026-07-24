local Path = require 'toolbox.system.path'

local entry_display = require 'telescope.pickers.entry_display'

---@class DisplayerColumn
---@field hl string|nil: optional, defaults to 'TelescopeResultsIdentifier'; highlight
--- group used for this column when the per-item value doesn't supply one
---@field width number|nil: optional fixed column width in cells
---@field remaining boolean|nil: optional; if true, column fills remaining space
--- (only valid on the last column)

---@class DisplayerOpts
---@field sep string|nil: optional, defaults to ' '; column separator
---@field columns DisplayerColumn[]|nil: optional; defaults to a single column with
--- hl='TelescopeResultsIdentifier' and remaining=true

---@alias DisplayValue string|(string|table)[]

--- Contains utilities that abstract away some of the boilerplate of building and
--- customizing telescope search entry/display constructs.
---
---@class EntryUtils
local EntryUtils = {}

local DEFAULT_HL = 'TelescopeResultsIdentifier'
local DEFAULT_COLUMNS = { { remaining = true, hl = DEFAULT_HL } }

local function resolve_opts(opts)
  opts = opts or {}
  return opts.columns or DEFAULT_COLUMNS, opts.sep or ' '
end

local function build_items(columns)
  local items = {}
  for i, c in ipairs(columns) do
    local item = {}
    if c.width ~= nil then
      item.width = c.width
    end
    if c.remaining ~= nil then
      item.remaining = c.remaining
    end
    items[i] = item
  end
  return items
end

local function to_tuples(display_value, columns)
  local tuples = {}

  if String.is(display_value) then
    tuples[1] = { display_value, (columns[1] and columns[1].hl) or DEFAULT_HL }
    return tuples
  end

  for i, v in ipairs(display_value) do
    local column_hl = (columns[i] and columns[i].hl) or DEFAULT_HL

    if Table.is(v) then
      tuples[i] = { v[1], v[2] or column_hl }
    else
      tuples[i] = { v, column_hl }
    end
  end

  return tuples
end

--- Creates a function used to construct telescope entry "display" values.
---
---@param display_value DisplayValue: either a single string (rendered in one
--- column), a list of strings (one per column), or a list of `{text, hl}` tuples
--- (per-item highlight overrides). Mixed lists are accepted.
---@param opts DisplayerOpts|nil: optional column/separator config
---@return fun(): (string, table): a function used to construct telescope entry
--- "display" values
function EntryUtils.make_display(display_value, opts)
  local columns, sep = resolve_opts(opts)

  local displayer = entry_display.create({
    separator = sep,
    items = build_items(columns),
  })

  return function()
    return displayer(to_tuples(display_value, columns))
  end
end

local function default_ordinal_fn(display_value, path)
  if String.is(display_value) then
    return #display_value > 0 and display_value or Path.basename(path)
  end

  if Table.is(display_value) then
    local parts = {}

    for _, v in ipairs(display_value) do
      if String.is(v) and #v > 0 then
        Array.append(parts, v)
      elseif Table.is(v) and String.is(v[1]) and #v[1] > 0 then
        Array.append(parts, v[1])
      end
    end

    if #parts > 0 then
      return table.concat(parts, ' ')
    end
  end

  return Path.basename(path)
end

--- Creates a function that creates telescope entries from individual search result
--- strings (assumed to be file names).
---
---@param display_fn fun(string): DisplayValue|nil: a function that accepts an
--- item's path and returns its display value (see `DisplayValue`)
---@param base_path string: the path to the directory in which search files are located
---@param ordinal_fn (fun(DisplayValue, string): string)|nil: optional; computes
--- the entry's `ordinal` from the display value and path. Defaults to the
--- space-joined text of every non-empty column (so all columns are searchable),
--- falling back to the file's basename
---@param opts DisplayerOpts|nil: optional column/separator config, forwarded
--- to `make_display` for every entry produced
---@return fun(string): (table): function that accepts a search item (assumed to be a file
--- name) and returns a table that models a telescope entry
function EntryUtils.make_entry_maker(display_fn, base_path, ordinal_fn, opts)
  ordinal_fn = ordinal_fn or default_ordinal_fn

  return function(item)
    local name = Path.basename(item)
    local path = Path.concat(base_path, item)
    local display_value = display_fn(path)
    if display_value == nil then
      display_value = name or path
    end

    return {
      value = name,
      display = EntryUtils.make_display(display_value, opts),
      ordinal = ordinal_fn(display_value, path),
      path = path,
      filename = name,
    }
  end
end

return EntryUtils
