local Lambda = require 'toolbox.functional.lambda'
local Env    = require 'toolbox.system.env'
local File   = require 'toolbox.system.file'
local Path   = require 'toolbox.system.path'
local Buffer = require 'utils.api.vim.buffer'
local Paths  = require 'utils.api.vim.path'
local System = require 'utils.api.vim.system'

local foreach = require('toolbox.utils.map').foreach

local safeget = Table.safeget


local SESSIONS_DIR = Paths.data() .. '/sessions'

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
  Trace('SessionInfo.new=%s', { this })
  return this
end

--- An thin api wrapper around session manager plugin.
---
---@class Session
local Session = {}

---@note: to expose SessionInfo
Session.SessionInfo = SessionInfo

local function api()
  return require 'persisted'
end

---@return string: the path to the directory where sessions are stored
function Session.sessions_dir()
  return SESSIONS_DIR
end


---@return boolean: true if a session exists for the cwd, false otherwise
function Session.exists()
  return api().session_exists()
end


local function filter_session()
  return true
end


--- Gets existing session.
---
---@return SessionInfo[]: an array of sessions, if any exist
function Session.list()
  local sessions = api().list() or {}

  return Stream.new(sessions)
    :map(SessionInfo.new)
    :filter(filter_session)
    :collect()
end


--- Gets the session w/ dir path == dir_path, if any.
---
---@param dir_path string: the absolute path of the dir that a session is tracking
---@param strict boolean|nil: optional, defaults to true; if true, raises an error if more
--- than one matching session is found
---@return SessionInfo|nil: the session w/ dir path == dir_path, if any
function Session.get(dir_path, strict)
  Debug('Session.get: fetching session for dir_path=%s', { dir_path })
  strict = Bool.or_default(strict, true)

  local matching = Stream.new(Session.list())
    :filter(function(s) return s.dir_path == dir_path end)
    :filter(filter_session)
    :collect()

  if strict and #matching > 1 then
    Err.raise('Found more than one matching session for dir=%s', dir_path)
  end

  local session = safeget(matching, 1)
  Debug('Session.get: session=%s', { session or {} })
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
  if String.not_nil_or_empty(opts.session) then
    return fmt('Loaded session file=%s', opts.session)
  elseif not opts.last then
    return fmt('Loaded session for cwd=%s', System.cwd())
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
  api().load(opts)

  InfoQuietly(get_load_log_msg(opts))
end


--- Loads the "last" session via the persisted.nvim plugin.
function Session.load_last()
  Session.load({ last = true })
end


--- Loads the session that for the cwd, if one exists. If it doesn't, falls back to
--- persisted.nvim plugin cwd session loading.
function Session.load_for_cwd()
  local current = Session.current()
  local file_path = safeget(current, 'file_path')

  Session.load({ session = file_path })
end


--- Loads the session file at the provided path.
---
---@param session string: a path to a session file
function Session.load_session(session)
  Session.load({ session = session })
end


--- Saves the current session after closing non-restorable buffers.
---
---@see Buffer.is_restorable
function Session.save()
  -- FIXME: figure out why this doesn't work
  -- foreach(
  --   Buffer.getall(Lambda.NOT(Buffer.is_restorable)),
  --   Buffer.close
  -- )

  api().save()

  local cwd = Path.basename(System.cwd())
  InfoQuietly('Session saved successfully for dir=%s', { cwd })
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
    return Warn('Session.delete: error deleting session=%s; err=%s', { name, err })
  end

  InfoQuietly('Successfully deleted session=%s', { name })
end

return Session

