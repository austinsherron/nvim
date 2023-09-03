
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
---@param maybe any?: the value that might be a view mode
---@return ViewMode: the provided value if it's a valid ViewMode, otherwise turns the
--- default view mode
function ViewMode.orDefault(maybe)
  if _ViewMode.ALL:contains(maybe) then
    return maybe
  end

  -- nil is a semi-valid option, as it potentially indicates the default was desired
  if maybe ~= nil then
    Warn('View mode=%s is not a valid ViewMode', { maybe })
  end

  return _ViewMode.DEFAULT
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

---@note: so ViewMode is publically accessible
Buffer.ViewMode = ViewMode

return Buffer

