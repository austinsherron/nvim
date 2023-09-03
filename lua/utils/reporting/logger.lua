local LogLevel = require 'toolbox.log.level'
local Logger   = require 'toolbox.log.logger'
local Path     = require 'utils.api.vim.path'
local TMerge   = require 'utils.api.vim.tablemerge'
local Notify   = require 'utils.reporting.notify'


---@alias NvimLoggerOpts { persistent: boolean?, user_facing: boolean? }

---@type NvimLoggerOpts
local DEFAULT_OPTS = { persistent = false, user_facing = true }
---@type NvimLoggerOpts
local DEFAULT_QUIET_OPTS = { persistent = false, user_facing = false }
local DEFAULT_LOG_FILENAME = 'nvim-user.log'

--- A neovim runtime logger.
---
---@class NvimLogger
---@field private log_filepath string: the path to the log file
---@field private logger Logger: file logger
---@field private default_opts NvimLoggerOpts: default logger options; can be overridden
--- via method level options arguments
local NvimLogger = {}
NvimLogger.__index = NvimLogger

--- Constructor
---
---@param log_filename string?: the name of the file to which to log; optional, defaults
--- nvim-user.log
---@param log_level LogLevel?: the current log level optional
---@param default_opts NvimLoggerOpts?: default logger options can be overridden
--- via method level options arguments
---@return NvimLogger: a new NvimLogger instance
function NvimLogger.new(log_filename, log_level, default_opts)
  local log_filepath = Path.log() .. '/' .. (log_filename or DEFAULT_LOG_FILENAME)
  local logger = Logger.new(log_filepath, log_level or LogLevel.default())

  return setmetatable({
    logger       = logger,
    default_opts = default_opts or DEFAULT_OPTS,
    log_filepath = log_filepath,
  }, NvimLogger)
end


---@private
function NvimLogger:do_log(method, to_log, args, opts)
  -- at this point, none of the values in opts are actually used by this logger, but that
  -- is likely to change in the near future; pass opts along for that eventuality
  self.logger[method](self.logger, to_log, args, opts)

  opts = TMerge.mergeleft(self.default_opts, opts or {})
  -- user facing is only used here and so shouldn't be passed to notify
  local user_facing, options = Table.split_one(opts, 'user_facing')

  if user_facing then
    Notify[method](to_log, args, options)
  end
end


--- Logs a "trace" level message during neovim runtime.
---
---@param to_log any: the formattable string or object to log
---@param args any[]?: an array of objects to format into to_log
---@param opts NvimLoggerOpts?: options that control logging behavior
function NvimLogger:trace(to_log, args, opts)
  self:do_log('trace', to_log, args, TMerge.mergeleft(DEFAULT_QUIET_OPTS, opts))
end


--- Logs a "debug" level message during neovim runtime.
---
---@param to_log any: the formattable string or object to log
---@param args any[]?: an array of objects to format into to_log
---@param opts NvimLoggerOpts?: options that control logging behavior
function NvimLogger:debug(to_log, args, opts)
  self:do_log('debug', to_log, args, TMerge.mergeleft(DEFAULT_QUIET_OPTS, opts))
end


--- Logs an "info" level message during neovim runtime.
---
---@param to_log any: the formattable string or object to log
---@param args any[]?: an array of objects to format into to_log
---@param opts NvimLoggerOpts?: options that control logging behavior
function NvimLogger:info(to_log, args, opts)
  self:do_log('info', to_log, args, opts)
end


--- Logs a "warn" level message during neovim runtime.
---
---@param to_log any: the formattable string or object to log
---@param args any[]?: an array of objects to format into to_log
---@param opts NvimLoggerOpts?: options that control logging behavior
function NvimLogger:warn(to_log, args, opts)
  self:do_log('warn', to_log, args, opts)
end


--- Logs an "error" level message during neovim runtime.
---
---@param to_log any: the formattable string or object to log
---@param args any[]?: an array of objects to format into to_log
---@param opts NvimLoggerOpts?: options that control logging behavior
function NvimLogger:error(to_log, args, opts)
  self:do_log('error', to_log, args, opts)
end


---@return string: the path to the log file
function NvimLogger:log_path()
  return self.log_filepath
end

return NvimLogger.new(DEFAULT_LOG_FILENAME, LogLevel.DEBUG)

