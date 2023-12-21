local Stream = require 'toolbox.extensions.stream'
local Env    = require 'toolbox.system.env'
local Path   = require 'toolbox.system.path'
local Buffer = require 'utils.api.vim.buffer'
local Paths  = require 'utils.api.vim.path'
local System = require 'utils.api.vim.system'


-- WARN: this alias is dependent on the impl of persisted.list; unfortunately, persisted
---      doesn't define any classes or aliases to import
---@alias SessionInfo { name: string, file_path: string, branch: string|nil, dir_path: string }

local SESSIONS_DIR = Paths.data() .. '/sessions'

--- An thin api wrapper around session manager plugin.
---
---@class Session
local Session = {}

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


--- Gets existing session.
---
---@return SessionInfo[]: an array of sessions, if any exist
function Session.list()
  return api().list() or {}
end


--- Gets the session w/ dir path == dir_path, if any.
---
---@param dir_path string: the absolute path of the dir that a session is tracking
---@param strict boolean|nil: optional, defaults to true; if true, raises an error if more
--- than one matching session is found
---@return SessionInfo|nil: the session w/ dir path == dir_path, if any
function Session.get(dir_path, strict)
  strict = Bool.or_default(strict, true)

  local home = Env.home()
  local matching = Stream.new(Session.list())
    :filter(function(s) return fmt('%s/%s', home, s.dir_path) == dir_path end)
    :filter(function(s) return s.branch == nil end)
    :collect()

  if strict and #matching > 1 then
    Err.raise('Found more than one matching session for dir=%s', dir_path)
  end

  return Table.unpack(matching)
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


--- Loads the "last" session.
function Session.load_last()
  Session.load({ last = true })
end


--- Loads the session that maps to the cwd, if one exists.
function Session.load_for_cwd()
  Session.load()
end


--- Loads the session file at the provided path.
---
---@param session string: a path to a session file
function Session.load_session(session)
  Session.load({ session = session })
end


--- Saves the current session.
function Session.save()
  api().save()

  local cwd = Path.basename(System.cwd())
  InfoQuietly('Session saved successfully for dir=%s', { cwd })
end

return Session

