local LoggerType = require 'toolbox.log.type'
local Buffer     = require 'utils.api.vim.buffer'
local View       = require 'utils.api.vim.view'

local OptionKey = Buffer.OptionKey
local ViewMode  = Buffer.ViewMode


--- Parameterizes opening log files.
---
---@class LogOpts
---@field type LoggerType|nil: optional, defaults to "nvim"; the type of log file to open
---@field viewmode ViewMode|nil: optional, defaults to "vsplit", the view mode in which to
--- open the log file (split, vsplit, etc.)

local LOG_FILETYPE = 'log'

---@type BufferOption[]
local BUFFER_OPTIONS = {
  { key = OptionKey.FILETYPE,   value = LOG_FILETYPE },
  { key = OptionKey.MODIFIABLE, value = false        },
}

---@type LogOpts
local DEFAULT_OPTS = {
  type     = LoggerType.NVIM,
  viewmode = ViewMode.VSPLIT,
}

--- Api for log file interactions.
---
---@class Logs
local Logs = {}

--- Opens a log file according to opts.
---
---@param opts LogOpts|nil: optional; parameterizes opening log files
function Logs.open(opts)
  opts = Table.combine(DEFAULT_OPTS, opts or {})

  local log_path = opts.type.log_path
  Buffer.open(opts.viewmode, log_path, BUFFER_OPTIONS)
end


--- Closes views that contain log files.
function Logs.close()
  View.close({ filetype = LOG_FILETYPE })
end

return Logs

