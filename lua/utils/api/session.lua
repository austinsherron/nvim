local Buffer = require 'utils.api.vim.buffer'
local Env = require 'toolbox.system.env'
local File = require 'toolbox.system.file'
local Path = require 'toolbox.system.path'
local Paths = require 'utils.api.vim.path'
local System = require 'utils.api.vim.system'

local safeget = Table.safeget

local persisted = Lazy.require 'persisted' ---@module 'persisted'

local LOGGER = GetLogger 'SESSION'
local SESSIONS_DIR = Paths.data() .. '/sessions/'

--- Contains information about a session.
---
--- WARN: this class's fields are dependent on the impl of persisted.nvim; unfortunately,
--- persisted doesn't define any classes or aliases to import.
---
---@class SessionInfo
---@field name string: the session's name
---@field file_path string: the path to the session's file
---@field dir_path string: the path to the cwd that the session tracks
local SessionInfo = {}
SessionInfo.__index = SessionInfo

--- Constructor
---
---@param s { name: string, file_path: string, dir_path: string }: a persisted.nvim
--- session object
---@return SessionInfo: a new instance
function SessionInfo.new(s)
  local home = Env.home()
  local this = Table.combine(s, {
    dir_path = fmt('%s/%s', home, s.dir_path),
  })

  this = setmetatable(this, SessionInfo)
  LOGGER:trace('SessionInfo.new=%s', { this })
  return this
end

--- Api wrapper around session manager plugin.
---
---@class Session
local Session = {}

---@note: to expose SessionInfo
Session.SessionInfo = SessionInfo

---@return string: the path to the directory where sessions are stored
function Session.sessions_dir()
  return SESSIONS_DIR
end

---@return boolean: true if a session exists for the cwd, false otherwise
function Session.exists()
  return persisted.session_exists()
end

local function filter_session()
  return true
end

--- Gets existing session.
---
---@return SessionInfo[]: an array of sessions, if any exist
function Session.list()
  local sessions = persisted.list() or {}

  return Stream.new(sessions):map(SessionInfo.new):filter(filter_session):collect()
end

local function non_unique_session_msg(dir_path)
  local dirname = Path.basename(dir_path)
  return fmt('Found more than one matching session for dir=%s', dirname)
end

--- Gets the session w/ dir path == dir_path, if any.
---
---@param dir_path string: the absolute path of the dir that a session is tracking
---@param strict boolean|nil: optional, defaults to false; if true, raises an error if
--- more than one matching session is found
---@return SessionInfo|nil: the session w/ dir path == dir_path, if any
function Session.get(dir_path, strict)
  LOGGER:debug('get: fetching session for dir_path=%s', { dir_path })
  local matching = Stream.new(Session.list())
    :filter(function(s)
      return s.dir_path == dir_path
    end)
    :filter(filter_session)
    :collect()

  if strict == true and #matching > 1 then
    Err.raise(non_unique_session_msg(dir_path))
  elseif #matching > 1 then
    LOGGER:warn(non_unique_session_msg(dir_path))
  end

  local session = safeget(matching, 1)
  LOGGER:debug('get: session=%s', { session or {} })
  return session
end

--- Gets the session for the cwd.
---
---@return SessionInfo|nil: the session for the cwd, if any
function Session.current()
  return Session.get(System.cwd())
end

local function get_load_log_msg(opts)
  -- WARN: this correctness of this logic is dependent on the impl of persisted.load;
  --       specifically, if opts.session is present and last == true, opts.session is
  --       loaded instead of the last session
  local dir = Path.basename(System.cwd())

  if String.not_nil_or_empty(opts.session) then
    return fmt('Loaded session file for dir=%s', dir)
  elseif not opts.last then
    return fmt('Loaded session for cwd=%s', dir)
  else
    return 'Loaded last session'
  end
end

--- Closes all buffers and loads a session based on opts:
---
---  * If session is present, loads the session file at that path, else...
---  * If last == true, loads the "last" session, else...
---  * If last is nil or false, loads the session for the cwd
---
--- WARN: the above logic is a description of the impl of the persisted.nvim plugin.
---
---@param opts { session: string|nil, last: boolean|nil }|nil: optional; parameterizes
--- session loading according to the above rules
function Session.load(opts)
  opts = opts or {}

  Buffer.closeall()
  persisted.load(opts)

  LOGGER:info(get_load_log_msg(opts), {}, { user_facing = true })
end

--- Loads the "last" session via the persisted.nvim plugin.
function Session.load_last()
  Session.load({ last = true })
end

--- Loads the session that for the cwd, if one exists. If it doesn't, falls back to
--- persisted.nvim plugin cwd session loading.
function Session.load_for_cwd()
  local current = Session.current() or {}
  local file_path = current.file_path

  Session.load({ session = file_path })
end

--- Loads the session file at the provided path.
---
---@param session string: a path to a session file
function Session.load_session(session)
  Session.load({ session = session })
end

--- Saves the session for the cwd.
---
--- TODO: "...after closing non-restorable buffers."
---
---@see Buffer.is_restorable
function Session.save()
  local session = Table.safeget(Session.current(), 'file_path')
  persisted.save({ session = session })

  local cwd = Path.basename(System.cwd())
  LOGGER:info('Saved session for dir=%s', { cwd }, { user_facing = true })
end

--- Switches from the current to the provided session. Switching a session involves:
---
---  * Saving the current session
---  * Closing current buffers
---  * CD'ing in into the session's directory
---  * Loading the session
---
---@param session SessionInfo: the session to load
function Session.switch(session)
  Session.save()
  Buffer.closeall()
  System.cd(session.dir_path)
  Session.load_session(session.file_path)
end

--- Deletes the file associated w/ the provided session.
---
---@note: This function doesn't use the session mgr plugin's deletion functionality, as it
--- doesn't allow deletion of arbitrary sessions (only the current session).
---
---@param session SessionInfo: the session to delete
function Session.delete(session)
  local path = session.file_path
  local name = session.name

  local err = File.delete(path)

  if err ~= nil then
    LOGGER:warn('Session.delete: error deleting session=%s; err=%s', { name, err })
  else
    LOGGER:info('Successfully deleted session=%s', { name }, { user_facing = true })
  end
end

return Session
