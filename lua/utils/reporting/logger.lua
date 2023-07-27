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
local NvimLogger = {}
NvimLogger.__index = NvimLogger

--- Constructor
--
---@param log_filename string?: the name of the file to which to log; optional, defaults
-- nvim-user.log
---@param log_level LogLevel?: the current log level; optional
---@return NvimLogger: a new NvimLogger instance
function NvimLogger.new(log_filename, log_level)
  log_filename = log_filename or DEFAULT_LOG_FILENAME

  local logger = Logger.new(
    Path.log() .. '/' .. log_filename,
    log_level or LogLevel.default()
  )

  return setmetatable({ logger = logger }, NvimLogger)
end


local function do_log(logger, method, msg, opts)
  opts = TMerge.mergeleft(DEFAULT_LOGGER_OPTS, opts or {})
  logger[method](logger, msg)

  if opts.user_facing then
    Notify[method](msg, opts.persistent)
  end
end


--- Logs a "trace" level message during neovim runtime.
--
---@param msg string: the message to log
---@param opts NvimLoggerOpts?: options that control logging behavior
function NvimLogger:trace(msg, opts)
  do_log(self.logger, 'trace', msg, opts)
end


--- Logs a "debug" level message during neovim runtime.
--
---@param msg string: the message to log
---@param opts NvimLoggerOpts?: options that control logging behavior
function NvimLogger:debug(msg, opts)
  do_log(self.logger, 'debug', msg, opts)
end


--- Logs an "info" level message during neovim runtime.
--
---@param msg string: the message to log
---@param opts NvimLoggerOpts?: options that control logging behavior
function NvimLogger:info(msg, opts)
  do_log(self.logger, 'info', msg, opts)
end


--- Logs a "warn" level message during neovim runtime.
--
---@param msg string: the message to log
---@param opts NvimLoggerOpts?: options that control logging behavior
function NvimLogger:warn(msg, opts)
  do_log(self.logger, 'warn', msg, opts)
end


--- Logs an "error" level message during neovim runtime.
--
---@param msg string: the message to log
---@param opts NvimLoggerOpts?: options that control logging behavior
function NvimLogger:error(msg, opts)
  do_log(self.logger, 'error', msg, opts)
end

local logger = NvimLogger.new(DEFAULT_LOG_FILENAME, LogLevel.INFO)

logger:warn('oh no')

return logger


