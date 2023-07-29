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


---@private
function NvimLogger:do_log(method, msg, opts)
  opts = TMerge.mergeleft(self.default_opts, opts or {})
  self.logger[method](self.logger, msg)

  if opts.user_facing then
    Notify[method](msg, opts.persistent)
  end
end


--- Logs a "trace" level message during neovim runtime.
--
---@param msg string: the message to log
---@param opts NvimLoggerOpts?: options that control logging behavior
function NvimLogger:trace(msg, opts)
  self:do_log('trace', msg, opts)
end


--- Logs a "debug" level message during neovim runtime.
--
---@param msg string: the message to log
---@param opts NvimLoggerOpts?: options that control logging behavior
function NvimLogger:debug(msg, opts)
  self:do_log('debug', msg, opts)
end


--- Logs an "info" level message during neovim runtime.
--
---@param msg string: the message to log
---@param opts NvimLoggerOpts?: options that control logging behavior
function NvimLogger:info(msg, opts)
  self:do_log('info', msg, opts)
end


--- Logs a "warn" level message during neovim runtime.
--
---@param msg string: the message to log
---@param opts NvimLoggerOpts?: options that control logging behavior
function NvimLogger:warn(msg, opts)
  self:do_log('warn', msg, opts)
end


--- Logs an "error" level message during neovim runtime.
--
---@param msg string: the message to log
---@param opts NvimLoggerOpts?: options that control logging behavior
function NvimLogger:error(msg, opts)
  self:do_log('error', msg, opts)
end

return NvimLogger.new(DEFAULT_LOG_FILENAME, LogLevel.INFO)

