local bool = require 'lib.lua.core.bool'
local log = require 'lib.lua.nvim.log'


local function make_err_msg(err_res, prefix)
  prefix = bool.ternary(prefix == nil, '', prefix .. ': ')
  return prefix .. err_res
end


--- Contains utility methods that wrap function calls and perform specific actions when the
--  functions raise errors.
--
---@class OnErr
local OnErr = {}

--- On error, displays a notification w/ the error message.
--
---@param f function: the function that might throw an error
---@param prefix string: optional prefix for error msg
function OnErr.alert(f, prefix)
  local ok, res = pcall(f)

  if ok then
    return res
  end

  local err_msg = make_err_msg(res, prefix)
  vim.notify(err_msg, 'error', { title = 'ERROR' })
end


--- On error, logs the error message.
--
---@param f function: the function that might throw an error
---@param prefix string: optional prefix for error msg
function OnErr.log(f, prefix)
  local ok, res = pcall(f, prefix)

  if ok then
    return res
  end

  local err_msg = make_err_msg(res, prefix)
  log.error(err_msg)
end

return OnErr

