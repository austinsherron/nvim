local Bool     = require 'lib.lua.core.bool'
local Table    = require 'lib.lua.core.table'
local Set      = require 'lib.lua.extensions.set'
local LogLevel = require 'lib.lua.log.level'
local Logger   = require 'lib.lua.log.logger'
local Path     = require 'utils.api.path'
local TMerge   = require 'utils.api.tablemerge'
local Notify   = require 'utils.reporting.notify'


local DEFAULT_LOG_FILENAME = 'nvim-user.log'

---@alias NvimLoggerOpts { persistent: boolean?, user_facing: boolean? }

---@type NvimLoggerOpts
local DEFAULT_LOGGER_OPTS = { persistent = false, user_facing = true }

--- A neovim runtime logger.
--
---@class NvimLogger
---@field private logger Logger: file logger
---@field private default_opts NvimLoggerOpts: default logger options; can be overridden
-- via method level options arguments
local NvimLogger = {}
NvimLogger.__index = NvimLogger

--- Constructor
--
---@param log_filename string?: the name of the file to which to log; optional, defaults
-- nvim-user.log
---@param log_level LogLevel?: the current log level optional
---@param default_opts NvimLoggerOpts?: default logger options can be overridden
-- via method level options arguments
---@return NvimLogger: a new NvimLogger instance
function NvimLogger.new(log_filename, log_level, default_opts)
  log_filename = log_filename or DEFAULT_LOG_FILENAME
  default_opts = default_opts or DEFAULT_LOGGER_OPTS

  local logger = Logger.new(
    Path.log() .. '/' .. log_filename,
    log_level or LogLevel.default()
  )

  return setmetatable({ logger = logger, default_opts = default_opts }, NvimLogger)
end


local function fmt_for_logger(to_log)
  return Bool.ternary(
    Table.is_table(to_log),
    function() return Table.unpack(to_log) end,
    to_log
  )
end


---@private
function NvimLogger:do_log(method, to_log, opts)
  self.logger[method](self.logger, fmt_for_logger(to_log))

  opts = TMerge.mergeleft(self.default_opts, opts or {})
  local user_facing = opts.user_facing
  -- user facing is only used here and so shouldn't be passed to notify
  opts = Table.pick_out(opts, Set.new({ 'user_facing' }))

  if user_facing then
    Notify[method](to_log, opts)
  end
end


--- Logs a "trace" level message during neovim runtime.
--
---@param to_log (any|any[])?: the messages/objects to log
---@param opts NvimLoggerOpts?: options that control logging behavior
function NvimLogger:trace(to_log, opts)
  self:do_log('trace', to_log, opts)
end


--- Logs a "debug" level message during neovim runtime.
--
---@param to_log (any|any[])?: the messages/objects to log
---@param opts NvimLoggerOpts?: options that control logging behavior
function NvimLogger:debug(to_log, opts)
  self:do_log('debug', to_log, opts)
end


--- Logs an "info" level message during neovim runtime.
--
---@param to_log (any|any[])?: the messages/objects to log
---@param opts NvimLoggerOpts?: options that control logging behavior
function NvimLogger:info(to_log, opts)
  self:do_log('info', to_log, opts)
end


--- Logs a "warn" level message during neovim runtime.
--
---@param to_log (any|any[])?: the messages/objects to log
---@param opts NvimLoggerOpts?: options that control logging behavior
function NvimLogger:warn(to_log, opts)
  self:do_log('warn', to_log, opts)
end


--- Logs an "error" level message during neovim runtime.
--
---@param to_log (any|any[])?: the messages/objects to log
---@param opts NvimLoggerOpts?: options that control logging behavior
function NvimLogger:error(to_log, opts)
  self:do_log('error', to_log, opts)
end

return NvimLogger.new(DEFAULT_LOG_FILENAME, LogLevel.DEBUG)

