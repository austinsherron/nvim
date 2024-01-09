local SessionApi = require 'utils.api.session'
local Confirm    = require 'utils.api.vim.confirm'

local ActionUtils = require('plugins.extensions.search').Telescope.ActionUtils

local telescope = require 'telescope'
local actions   = require 'telescope.actions'

local SessionInfo = SessionApi.SessionInfo


--- Contains functions that implement extended (custom) session manager functionality.
---
---@class Session
local Session = {}

local function make_delete_session_action()
  local confirm = function(s, _)
    return Confirm.dialog(fmt(
      'Are you sure you want to delete %s ?',
      s.display(s)
    ))
  end

  local action = function(s, _) return SessionApi.delete(s) end
  -- TODO: I can probably do better than to just close the buffer here, but to refresh it
  -- requires introducing an explicit dependency on the inner workings of the find_files
  -- telescope builtin; this is just fine for now
  local after = function(_, _, pb) actions.close(pb) end

  return Safe.ify(
    ActionUtils.make_selection_action(confirm, action, after)
  )
end


local function default_action(selection)
  ---@note: assuming here that the selected session exists
  local session = SessionInfo.new(selection)

  GetLogger('SESSION'):info('Switching to session=%s', { session.name })
  SessionApi.switch(session)
end


local function make_keymap()
  return {
    { 'i', '<C-d>', make_delete_session_action() },
    { 'n', 'dd',    make_delete_session_action() },
  }
end


local function make_attachment_action()
  return ActionUtils.replace_default_action(
    Safe.ify(default_action),
    make_keymap()
  )
end


local function sessions_picker()
  telescope.extensions.persisted.persisted({
    attach_mappings = make_attachment_action(),
    layout_strategy = 'vertical',
    layout_config   = { height = 0.4, width = 0.5 },
  })
end


--- Displays known sessions.
function Session.picker()
  sessions_picker()
end

return Session

