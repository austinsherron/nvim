local onerr = require 'nvim.lua.utils.onerr'


---@class Import
local Import = {}

--- Standard lua "require" wrapped w/ mandatory error handling.
--
---@see OnErr
--
---@param to_require string: the import string that references a lua module to require (import)
---@param error_handler OnErrStrategy: how to handle errors
---@return any?: the value returned by the required module, or nil if there's an error
function Import.safe_require(to_require, error_handler)
  local f = function() return require(to_require) end
  return onerr[error_handler](f)
end

return Import

