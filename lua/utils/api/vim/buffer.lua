
--- Specifies how to view/open a buffer
---
---@enum ViewMode
local ViewMode = {
  STANDALONE = 'e',         -- open standalone buffer
  SPLIT      = 'split',     -- open buffer in split (over-under)
  VSPLIT     = 'vsplit',    -- open buffer in vertical split (side-by-side)
}

local _ViewMode = {
  ALL     = Set.new(Table.values(ViewMode)),
  DEFAULT = ViewMode.STANDALONE,
}

---@return ViewMode: the default view mode
function ViewMode.default()
  return _ViewMode.DEFAULT
end


--- Returns the provided value if it's a valid ViewMode, otherwise it returns the default
--- view mode
---
---@param o any?: the value that might be a view mode
---@return ViewMode: the provided value if it's a valid ViewMode, otherwise turns the
--- default view mode
function ViewMode.orDefault(o)
  if ViewMode.is_valid(o) then
    return o
  end

  -- nil is a semi-valid option, as it potentially indicates the default was desired
  if o ~= nil then
    Warn('View mode=%s is not a valid ViewMode', { o })
  end

  return _ViewMode.DEFAULT
end


--- Checks that the provided object is a valid ViewMode.
---
---@param o any|nil: the object to check
---@return boolean: true if o is a valid ViewMode, false otherwise
function ViewMode.is_valid(o)
  return _ViewMode.ALL:contains(o)
end

local Buffer = {}

--- Opens a buffer for the file at the provided path.
---
---@param path string: the path to the file to open
---@param view_mode ViewMode?: how to open the buffer; optional, defaults to
--- ViewMode.STANDALONE, at the time of writing
function Buffer.open(path, view_mode)
  view_mode = view_mode or ViewMode.default()
  vim.cmd(view_mode .. ' ' .. path)
end


---@see vim.api.nvim_list_bufs
---@return any[]: current buffer handles
function Buffer.getall()
  return vim.api.nvim_list_bufs()
end

---@note: so ViewMode is publicly accessible
Buffer.ViewMode = ViewMode

return Buffer

