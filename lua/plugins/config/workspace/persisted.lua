local Session = require 'utils.api.session'

--- Contains functions for configuring the persisted session manager plugin.
---
---@class Persisted
local Persisted = {}

---@return table: a table that contains configuration values for the persisted session
--- manager plugin
function Persisted.opts()
  return {
    -- FIXME: see FIXME in Session.save
    -- autosave = false,
    save_dir = Session.sessions_dir(),
  }
end

return Persisted
