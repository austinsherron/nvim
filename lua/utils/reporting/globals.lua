local Lazy     = require 'toolbox.utils.lazy'


-- globally accessible, lazy-loaded nvim logger instance
---@type fun(): l: NvimLogger
GetLogger = Lazy.require('utils.reporting.logger')

-- global logging helpers
function Trace(...) GetLogger():trace(...) end
function Debug(...) GetLogger():debug(...) end
function Info (...) GetLogger():info (...) end
function Warn (...) GetLogger():warn (...) end
function Error(...) GetLogger():error(...) end

function InfoQuietly (tl, a) GetLogger():info (tl, a, { user_facing = false }) end
function WarnQuietly (tl, a) GetLogger():warn (tl, a, { user_facing = false }) end
function ErrorQuietly(tl, a) GetLogger():error(tl, a, { user_facing = false }) end


--- Small decorator that executes the provided "this" fn, captures its return value, logs
--- a msg using "log_fn", then returns the captured return value of this.
---
---@generic T
---@param this fun(...): r: T: the function to run before logging; its return value is
--- captured, passed to log_fn for logging, then returned
---@param log_fn (fun(m: any?): n: nil): a function that performs logging; passed the
--- return value of this; more or less intended to be an anonymous function that wraps
--- one of the above globals
---@param ... any?: args to pass to this, if any
---@return T: the return value of this
function ThisThenLog(this, log_fn, ...)
  local ret_val = this(...)
  log_fn(ret_val)
  return ret_val
end

