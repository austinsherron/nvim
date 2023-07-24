
--- Specifies what kind of message is being logged, and its level of
--  importance/visibility/urgency.
--
---@enum Urgency
local Urgency = {
  DEBUG = vim.log.levels.DEBUG,
  INFO = vim.log.levels.INFO,
  WARN = vim.log.levels.WARN,
  ERROR = vim.log.levels.ERROR,
}

--- A basic wrapper around calls to the vim notify api.
--
---@class Notify
local Notify = {}

local function log_msg(msg, log_level)
  vim.notify(msg, log_level)
end


--- Logs a "debug" level message during neovim runtime.
--
---@param msg string: the message to log
function Notify.debug(msg)
  log_msg(msg, Urgency.DEBUG)
end


--- Logs an "info" level message during neovim runtime.
--
---@param msg string: the message to log
function Notify.info(msg)
  log_msg(msg, Urgency.INFO)
end


--- Logs a "warn" level message during neovim runtime.
--
---@param msg string: the message to log
function Notify.warn(msg)
  log_msg(msg, Urgency.WARN)
end


--- Logs an "error" level message during neovim runtime.
--
---@param msg string: the message to log
function Notify.error(msg)
  log_msg(msg, Urgency.ERROR)
end

return Notify

