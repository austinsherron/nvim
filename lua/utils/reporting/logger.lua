local LogLevel = require 'toolbox.log.level'
local Logger = require 'toolbox.log.logger'
local LoggerType = require 'toolbox.log.type'
local Notify = require 'utils.reporting.notify'
local NvimConfig = require 'utils.config'
local TMerge = require 'utils.api.vim.tablemerge'

---@alias NvimLoggerOpts { persistent: boolean?, user_facing: boolean? }

---@type NvimLoggerOpts
local DEFAULT_OPTS = { persistent = false, user_facing = false }

--- A neovim runtime logger.
---
---@class NvimLogger
---@field private logger Logger: file logger
---@field private default_opts NvimLoggerOpts: default logger options; can be overridden
--- via method level options arguments
local NvimLogger = {}
NvimLogger.__index = NvimLogger

--- Constructor
---
---@param log_level LogLevel?: the current log level optional
---@param default_opts NvimLoggerOpts?: default logger options can be overridden
--- via method level options arguments
---@param label string|nil: optional; an optional prefix label for logged messages
---@return NvimLogger: a new NvimLogger instance
function NvimLogger.new(log_level, default_opts, label)
  local logger = Logger.new(LoggerType.NVIM, log_level or LogLevel.default(), label)

  return setmetatable({
    logger = logger,
    default_opts = TMerge.mergeright(default_opts or {}, DEFAULT_OPTS),
  }, NvimLogger)
end

--- Creates a new sub-logger from this instance using the provided label.
---
---@param label string: a prefix label for logged messages
---@return NvimLogger: a new sub-logger instance w/ the provided label
function NvimLogger:sub(label)
  return setmetatable({
    logger = self.logger:sub(label),
    default_opts = self.default_opts or {},
  }, NvimLogger)
end

---@private
function NvimLogger:do_log(method, to_log, args, opts)
  opts = TMerge.mergeright(opts or {}, self.default_opts, DEFAULT_OPTS)

  self.logger[method](self.logger, to_log, args, opts)

  if opts.user_facing ~= true then
    return
  end

  opts = TMerge.mergeleft(self.default_opts, opts)
  _, opts = Table.split_one(opts, 'user_facing')

  Notify[method](to_log, args, opts)
end

--- Logs a "trace" level message during neovim runtime.
---
---@param to_log any: the formattable string or object to log
---@param args any[]?: an array of objects to format into to_log
---@param opts NvimLoggerOpts?: options that control logging behavior
function NvimLogger:trace(to_log, args, opts)
  self:do_log('trace', to_log, args, opts)
end

--- Logs a "debug" level message during neovim runtime.
---
---@param to_log any: the formattable string or object to log
---@param args any[]?: an array of objects to format into to_log
---@param opts NvimLoggerOpts?: options that control logging behavior
function NvimLogger:debug(to_log, args, opts)
  self:do_log('debug', to_log, args, opts)
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
  return self.logger:log_path()
end

local function current_level()
  return NvimConfig.log_level() or LogLevel.default()
end

return NvimLogger.new(current_level())
