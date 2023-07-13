
--- Specifies what kind of message is being logged, and it's level of "important"/visibility/urgency.
--
---@enum LogLevel
local LogLevel = {
  DEBUG = vim.log.levels.DEBUG,
  INFO = vim.log.levels.INFO,
  WARN = vim.log.levels.WARN,
  ERROR = vim.log.levels.ERROR,
}

--- A basic wrapper around calls to the vim notify api.
--
---@class Logger
local Logger = {}

local function log_msg(msg, log_level)
  vim.notify(msg, log_level)
end


--- Logs a "debug" level message during neovim runtime.
--
---@param msg string: the message to log
function Logger.debug(msg)
  log_msg(msg, LogLevel.DEBUG)
end


--- Logs an "info" level message during neovim runtime.
--
---@param msg string: the message to log
function Logger.info(msg)
  log_msg(msg, LogLevel.INFO)
end


--- Logs a "warn" level message during neovim runtime.
--
---@param msg string: the message to log
function Logger.warn(msg)
  log_msg(msg, LogLevel.WARN)
end


--- Logs an "error" level message during neovim runtime.
--
---@param msg string: the message to log
function Logger.error(msg)
  log_msg(msg, LogLevel.ERROR)
end

return Logger

