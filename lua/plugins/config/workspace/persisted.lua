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
    -- NOTE: same as default, but making it explicit for use in custom integration
    branch_separator = Session.Contstants.BRANCH_SEP,
    save_dir = Session.Contstants.SESSIONS_DIR,
    should_autosave = Session.should_save,
  }
end

return Persisted
