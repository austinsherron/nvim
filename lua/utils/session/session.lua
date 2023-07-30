local File             = require 'lib.lua.system.fs'
local Path             = require 'lib.lua.system.path'
local Shell            = require 'lib.lua.system.shell'
local Telescope        = require 'plugins.extensions.telescope'
local Builtins         = require 'telescope.builtin'
local SessionConfigMgr = require 'utils.session.configmgr'
local SessionNamer     = require 'utils.session.name'


local function get_session_path(config, name)
  name = name or SessionNamer.mkname(config.name)
  return config.dir .. '/' .. name
end


--- Implements core session management functionality.
--
---@class Session
local Session = {}

local function save_session(path)
  vim.cmd('mks! ' .. path)
end


--- Saves a session based on the saved config.
function Session.save()
  local config = SessionConfigMgr.load()
  local path = get_session_path(config)

  save_session(path)
end


local function load_session(path)
  local exists, err = File.exists(path)

  if err ~= nil then
    Warn('Error encountered closing file=' .. path)
  end

  if exists then
    return vim.cmd('source ' .. path)
  end

  Warn('Session=' .. path .. ' does not exist')
end


--- Loads a session based either on the saved config or the provided name.
--
---@param name string?: if present, this function will use name to find the session to load
function Session.load(name)
  local config = SessionConfigMgr.load()
  local path = get_session_path(config, name)

  load_session(path)
end


local function delete_session(path)
  local err = File.delete(path)

  if err ~= nil then
    Warn(err)
  end
end


--- Deletes a session based either on the saved config or the provided name.
--
---@param name string?: if present, this function will use name to find the session to delete
function Session.delete(name)
  local config = SessionConfigMgr.load()
  local path = get_session_path(config, name)

  delete_session(path)
end


local function make_list_sessions_action()
  return Telescope.make_new_action(
    function(selection)
      local session = selection[1]
      Session.load(session)
    end
  )
end


local function list_sessions(config)
  Builtins.find_files({
    attach_mappings = make_list_sessions_action(),
    cwd             = config.dir,
    path_display    = function(_, name) return SessionNamer.format(name) end,
    prompt_title    = 'Sessions',
  })
end


---Displays known sessions based on the saved config.
function Session.list()
  local config = SessionConfigMgr.load()
  list_sessions(config)
end

return Session

