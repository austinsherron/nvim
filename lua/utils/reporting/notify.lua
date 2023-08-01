local LogFormatter = require 'lib.lua.log.formatter'


--- Specifies what kind of message is being logged, and its level of
--- importance/visibility/urgency.
---
---@enum Urgency
local Urgency = {
  TRACE = vim.log.levels.TRACE,
  DEBUG = vim.log.levels.DEBUG,
  INFO  = vim.log.levels.INFO,
  WARN  = vim.log.levels.WARN,
  ERROR = vim.log.levels.ERROR,
}

--- A basic wrapper around calls to the vim notify api.
---
---@class Notify
local Notify = {}

local function do_log(to_log, log_level, opts)
  to_log = LogFormatter.format(to_log)
  opts = opts or {}

  -- persistent == true means timeout == false, i.e.: no timeout
  local persistent = opts.persistent or false
  opts = Table.pick_out(opts, Set.new({ 'persistent' }))
  opts.timeout = ternary(persistent, false, opts.timeout)

  vim.notify(to_log, log_level, opts)
end


--- Logs a "trace" level message during neovim runtime.
---
---@param to_log (any|any[])?: the messages/objects to log
function Notify.trace(to_log, opts)
  do_log(to_log, Urgency.TRACE, opts)
end


--- Logs a "debug" level message during neovim runtime.
---
---@param to_log (any|any[])?: the messages/objects to log
function Notify.debug(to_log, opts)
  do_log(to_log, Urgency.DEBUG, opts)
end


--- Logs an "info" level message during neovim runtime.
---
---@param to_log (any|any[])?: the messages/objects to log
function Notify.info(to_log, opts)
  do_log(to_log, Urgency.INFO, opts)
end


--- Logs a "warn" level message during neovim runtime.
---
---@param to_log (any|any[])?: the messages/objects to log
function Notify.warn(to_log, opts)
  do_log(to_log, Urgency.WARN, opts)
end


--- Logs an "error" level message during neovim runtime.
---
---@param to_log (any|any[])?: the messages/objects to log
function Notify.error(to_log, opts)
  do_log(to_log, Urgency.ERROR, opts)
end

return Notify

