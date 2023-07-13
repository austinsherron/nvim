local onerr = require 'nvim.lua.utils.onerr'


---@class Safe
local Safe = {}

--- Basically pcall w/ mandatory error handling.
--
---@see OnErr
--
---@param to_call fun(): r: any?: the function to call
---@param error_handler OnErrStrategy?: how to handle errors; defaults to "notify"
---@return any?: the value returned by the to_call
function Safe.call(to_call, error_handler)
  error_handler = error_handler or 'notify'
  return onerr[error_handler](to_call, error_handler)
end


--- Standard lua require wrapped w/ mandatory error handling.
--
---@see OnErr
--
---@param to_require string: the import string that references a lua module to require (import)
---@param error_handler OnErrStrategy?: how to handle errors; defaults to "notify"
---@return any?: the value returned by the required module, or nil if there's an error
function Safe.require(to_require, error_handler)
  local to_call = function() return require(to_require) end
  return Safe.call(to_call, error_handler)
end

return Safe

