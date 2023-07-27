local Bool = require 'lib.lua.core.bool'


--- Specifies what kind of message is being logged, and its level of
--  importance/visibility/urgency.
--
---@enum Urgency
local Urgency = {
  TRACE = vim.log.levels.TRACE,
  DEBUG = vim.log.levels.DEBUG,
  INFO  = vim.log.levels.INFO,
  WARN  = vim.log.levels.WARN,
  ERROR = vim.log.levels.ERROR,
}

--- A basic wrapper around calls to the vim notify api.
--
---@class Notify
local Notify = {}

local function log_msg(msg, log_level, persistent)
  persistent = persistent or false
  local opts = Bool.ternary(persistent, { timeout = false }, nil)

  vim.notify(msg, log_level, opts)
end


--- Logs a "trace" level message during neovim runtime.
--
---@param msg string: the message to log
function Notify.trace(msg, persistent)
  log_msg(msg, Urgency.TRACE, persistent)
end


--- Logs a "debug" level message during neovim runtime.
--
---@param msg string: the message to log
function Notify.debug(msg, persistent)
  log_msg(msg, Urgency.DEBUG, persistent)
end


--- Logs an "info" level message during neovim runtime.
--
---@param msg string: the message to log
function Notify.info(msg, persistent)
  log_msg(msg, Urgency.INFO, persistent)
end


--- Logs a "warn" level message during neovim runtime.
--
---@param msg string: the message to log
function Notify.warn(msg, persistent)
  log_msg(msg, Urgency.WARN, persistent)
end


--- Logs an "error" level message during neovim runtime.
--
---@param msg string: the message to log
function Notify.error(msg, persistent)
  log_msg(msg, Urgency.ERROR, persistent)
end

return Notify

