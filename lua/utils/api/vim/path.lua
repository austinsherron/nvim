---@diagnostic disable: return-type-mismatch

local stdpath = vim.fn.stdpath


--- Contains methods for interacting w/ various user "system" directories.
---
---@class Path
local Path = {}

---@return string: the path to the cache dir
function Path.cache()
  return stdpath('cache')
end


---@return string: the path to the config dir
function Path.config()
  return stdpath('config')
end


---@return string: the path to the data dir
function Path.data()
  return stdpath('data')
end


---@return string: the path to the log dir
function Path.log()
  return stdpath('log')
end

return Path

