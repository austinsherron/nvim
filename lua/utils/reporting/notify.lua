local LogFormatter = require 'toolbox.log.formatter'
local LogLevel     = require 'toolbox.log.level'


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

local function do_log(level, to_log, args, opts)
  args = args or {}
  opts = opts or {}

  to_log = LogFormatter.format(LogLevel.NIL, to_log, args, opts)

  -- persistent == true means timeout == false, i.e.: no timeout
  local persistent = opts.persistent or false
  opts = Table.pick_out(opts, Set.only('persistent'))
  opts.timeout = ternary(persistent, false, opts.timeout)

  vim.notify(to_log, level, opts)
end


--- Logs a "trace" level message via the vim.notify api.
---
---@param to_log any: the formattable string or object to log
---@param args any[]|nil: an array of objects to format into to_log
---@param opts table|nil: options that control logging behavior
function Notify.trace(to_log, args, opts)
  do_log(Urgency.TRACE, to_log, args, opts)
end


--- Logs a "debug" level message via the vim.notify api.
---
---@param to_log any: the formattable string or object to log
---@param args any[]|nil: an array of objects to format into to_log
---@param opts table|nil: options that control logging behavior
function Notify.debug(to_log, args, opts)
  do_log(Urgency.DEBUG, to_log, args, opts)
end


--- Logs an "info" level message via the vim.notify api.
---
---@param to_log any: the formattable string or object to log
---@param args any[]|nil: an array of objects to format into to_log
---@param opts table|nil: options that control logging behavior
function Notify.info(to_log, args, opts)
  do_log(Urgency.INFO, to_log, args, opts)
end


--- Logs a "warn" level message via the vim.notify api.
---
---@param to_log any: the formattable string or object to log
---@param args any[]|nil: an array of objects to format into to_log
---@param opts table|nil: options that control logging behavior
function Notify.warn(to_log, args, opts)
  do_log(Urgency.WARN, to_log, args, opts)
end


--- Logs an "error" level message via the vim.notify api.
---
---@param to_log any: the formattable string or object to log
---@param args any[]|nil: an array of objects to format into to_log
---@param opts table|nil: options that control logging behavior
function Notify.error(to_log, args, opts)
  do_log(Urgency.ERROR, to_log, args, opts)
end

return Notify

