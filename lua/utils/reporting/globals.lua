local Lazy = require 'toolbox.utils.lazy'


-- globally accessible, lazy-loaded nvim logger instance
---@type fun(): NvimLogger
GetLogger = function()
  return Lazy.require('utils.reporting.logger')  ---@module 'utils.reporting.logger'
end

-- global logging helpers
function Trace(...) GetLogger():trace(...) end
function Debug(...) GetLogger():debug(...) end
function Info (...) GetLogger():info (...) end
function Warn (...) GetLogger():warn (...) end
function Error(...) GetLogger():error(...) end

function InfoQuietly (tl, a) GetLogger():info (tl, a, { user_facing = false }) end
function WarnQuietly (tl, a) GetLogger():warn (tl, a, { user_facing = false }) end
function ErrorQuietly(tl, a) GetLogger():error(tl, a, { user_facing = false }) end

