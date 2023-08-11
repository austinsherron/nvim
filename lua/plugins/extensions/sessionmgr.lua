local SessionConfigMgr = require 'plugins.config.editor.sessionmgr'
local Telescope        = require 'plugins.extensions.telescope'
local session_utils    = require 'session_manager.utils'
local actions          = require 'telescope.actions'
local Builtins         = require 'telescope.builtin'
local Env              = require 'toolbox.system.env'
local File             = require 'toolbox.system.file'
local Confirm          = require 'utils.api.vim.confirm'


--- Contains functions that implement extended (custom) session manager functionality.
---
---@class SessionMgr
local SessionMgr = {}

local function make_session_path(name)
  return SessionConfigMgr.sessions_dir() .. '/' .. name
end


local function delete_session(name)
  local err = File.delete(make_session_path(name))

  if err ~= nil then
    return Warn({ 'Session ext: error deleting session=', name, '; err=', err })
  end

  Info({ 'Successfully deleted session=', name })
end


local function make_delete_session_action()
  local confirm = function(s, _)
    return Confirm.dialog('Are you sure you want to delete ' .. s.value .. '?')
  end

  local action = function(s, _) return delete_session(s.value) end
  -- TODO: I can probably do better than to just close the buffer here, but to refresh it
  -- requires introducing an explicit dependency on the inner workings of the find_files
  -- telescope builtin; this is just fine for now
  local after = function(_, _, pb) actions.close(pb) end

  return Telescope.make_selection_action(confirm, action, after)
end


local function make_list_sessions_action()
  return Telescope.make_new_action(
    function(selection)
      local session = selection[1]
      local path = make_session_path(session)

      session_utils.load_session(path, false)
    end,
    {
      { 'i', '<C-d>', make_delete_session_action() },
      { 'n', 'dd',    make_delete_session_action() },
    }
  )
end

local PATH_SEP   = '/'
local PATH_SEP_0 = '__'
local PATH_SEP_1 = '%%'

local function format_session_name(name)
  local path = name
    :gsub(PATH_SEP_0, PATH_SEP)
    :gsub(PATH_SEP_1, PATH_SEP)
    :gsub(Env.dev_root() .. PATH_SEP, 'WORKSPACE:')
    :gsub(Env.home(), '~')

  return 'Dir: ' .. path
end


--- Displays known sessions.
function SessionMgr.list()
  Builtins.find_files({
    attach_mappings = make_list_sessions_action(),
    cwd             = SessionConfigMgr.sessions_dir(),
    path_display    = function(_, name) return format_session_name(name) end,
    prompt_title    = 'Sessions',
  })
end

return SessionMgr

