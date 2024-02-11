local Interaction = require 'utils.api.vim.interaction'
local SessionApi = require 'utils.api.session'

local ActionUtils = require('plugins.extensions.search').Telescope.ActionUtils

local persisted = require 'persisted'
local session_finder = require 'telescope._extensions.persisted.finders'
local telescope = require 'telescope'

local AfterSelect = ActionUtils.AfterSelect
local SessionInfo = SessionApi.SessionInfo

--- Contains functions that implement extended (custom) session manager functionality.
---
---@class Session
local Session = {}

local function make_delete_session_action()
  local confirm = function(s, _)
    return Interaction.confirmation_dialog(
      fmt('Are you sure you want to delete %s ?', s.display(s))
    )
  end

  local action = function(s, _)
    return SessionApi.delete(s)
  end

  local finder = function()
    -- WARN: I'm duplicating some of the persisted telescope picker logic here... so I can
    -- have custom deletion key bindings... 🙃
    return session_finder.session_finder(persisted.list())
  end

  local after = AfterSelect.refresh_prompt(finder)
  return Safe:ify(ActionUtils.make_selection_action(confirm, action, after))
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
    { 'n', 'dd', make_delete_session_action() },
  }
end

local function make_attachment_action()
  return ActionUtils.replace_default_action(Safe:ify(default_action), make_keymap())
end

local function sessions_picker()
  telescope.extensions.persisted.persisted({
    attach_mappings = make_attachment_action(),
    layout_strategy = 'vertical',
    layout_config = { height = 0.3, width = 0.5 },
  })
end

--- Displays known sessions.
function Session.picker()
  sessions_picker()
end

return Session
