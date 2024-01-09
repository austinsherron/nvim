local Lazy = require 'toolbox.utils.lazy'

local Logger = Lazy.require 'utils.reporting.logger' ---@module 'utils.reporting.logger'

-- lazy-loaded sub-loggers
local LOGGERS = {
  AUTOCMD = Lazy.value(function()
    return Logger:sub 'AUTOCMD'
  end),
  CMP = Lazy.value(function()
    return Logger:sub 'CMP'
  end),
  INIT = Lazy.value(function()
    return Logger:sub 'INIT'
  end),
  EFM = Lazy.value(function()
    return Logger:sub 'EFM'
  end),
  EXT = Lazy.value(function()
    return Logger:sub 'EXT'
  end),
  KEYMAP = Lazy.value(function()
    return Logger:sub 'KEYMAP'
  end),
  LSP = Lazy.value(function()
    return Logger:sub 'LSP'
  end),
  LUA_LS = Lazy.value(function()
    return Logger:sub 'LUA_LS'
  end),
  PLUGINS = Lazy.value(function()
    return Logger:sub 'PLUGINS'
  end),
  SESSION = Lazy.value(function()
    return Logger:sub 'SESSION'
  end),
  UI = Lazy.value(function()
    return Logger:sub 'UI'
  end),
  USERCMD = Lazy.value(function()
    return Logger:sub 'USERCMD'
  end),
  VIEW = Lazy.value(function()
    return Logger:sub 'VIEW'
  end),
}

--- Gets the global logger instance or the scoped sub-logger instance for the provided
--- label.
---
---@param label string|nil: optional; the sub-logger to get
---@return NvimLogger: the global logger instance, if label is nil, or the sub-logger
--- instance for the provided label
---@error if the provided label doesn't correspond to a known sub-logger
local function getLogger(label)
  if label == nil then
    return Logger
  end

  if LOGGERS[label] == nil then
    error(string.format('No sub-logger=%s', label))
  end

  return LOGGERS[label] --[[@as NvimLogger]]
end

return getLogger
