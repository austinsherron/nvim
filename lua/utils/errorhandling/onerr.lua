local bool = require 'lib.lua.core.bool'
local log = require 'nvim.lua.utils.log'


local function make_err_msg(err_res, prefix)
  prefix = bool.ternary(prefix == nil, '', function() return prefix .. ': ' end)
  return prefix .. (err_res or '')
end

-- A type alias that allows enforcement of passing specific method names to functions that
-- accept them as arguments.
--
-- TODO: figure out if there's a better way to achieve the above goal w/out hard-coding
--       method names.
--
---@alias OnErrStrategy
---| "log"       # see OnErr.log
---| "notify"    # see OnErr.notify

--- Contains utility methods that wrap function calls and perform specific actions when the
--  functions raise errors.
--
---@class OnErr
local OnErr = {}

--- On error, logs the error message.
--
---@param f fun(): any?: the function that might throw an error
---@param prefix string?: optional prefix for error msg
function OnErr.log(f, prefix)
  local ok, res = pcall(f)

  if ok then
    return res
  end

  local err_msg = make_err_msg(res, prefix)
  log.error(err_msg)
end


--- On error, displays a notification w/ the error message.
--
---@param f fun(): any?: the function that might throw an error
---@param prefix string?: optional prefix for error msg
function OnErr.notify(f, prefix)
  local ok, res = pcall(f)

  if ok then
    return res
  end

  local err_msg = make_err_msg(res, prefix)
  vim.notify(err_msg, 'error', { title = 'Error' })
end

return OnErr
