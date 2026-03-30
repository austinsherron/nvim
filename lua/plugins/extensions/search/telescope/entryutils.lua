local Path = require 'toolbox.system.path'

local entry_display = require 'telescope.pickers.entry_display'

--- Contains utilities that abstract away some of the boilerplate of building and
--- customizing telescope search entry/display constructs.
---
---@class EntryUtils
local EntryUtils = {}

--- Creates a function used to construct telescope entry "display" values.
---
---@param display_name string: the string value to display for an entry
---@return fun(): (string, table): a function used to construct telescope entry "display"
--- values
function EntryUtils.make_display(display_name)
  local displayer = entry_display.create({
    separator = ' ',
    items = {
      { remaining = true },
    },
  })

  return function()
    return displayer({ { display_name, 'TelescopeResultsIdentifier' } })
  end
end

--- Creates a function that creates telescope entries from individual search result
--- strings (assumed to be file names).
---
---@param display_name_fn fun(string): (string): a function that accepts an item's path
--- and returns a display name string
---@param base_path string: the path to the directory in which search files are located
---@return fun(string): (table): function that accepts a search item (assumed to be a file
--- name) and returns a table that models a telescope entry
function EntryUtils.make_entry_maker(display_name_fn, base_path)
  return function(item)
    local name = Path.basename(item)
    local path = Path.concat(base_path, item)
    local display_name = display_name_fn(path) or name

    return {
      value = name,
      display = EntryUtils.make_display(display_name),
      ordinal = display_name,
      path = path,
      filename = name,
    }
  end
end

return EntryUtils
