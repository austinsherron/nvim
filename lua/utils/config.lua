local Bool   = require 'toolbox.core.bool'
local String = require 'toolbox.core.string'
local Env    = require 'toolbox.system.env'


--- Reads neovim configuration values from the environment. Neovim config env vars are
--- prefixed w/ "NEOVIM_".
---
---@class NvimConfig
---@field [any] any
local NvimConfig = {}
NvimConfig.__index = NvimConfig

--- Constructor
---
---@return NvimConfig: a new instance
function NvimConfig.new()
  return setmetatable({}, NvimConfig)
end


--- Custom index metamethod that permits the reading of neovim config env vars via
--- function calls of the following from:
---
---  * NEOVIM_LOG_LEVEL="info"           ->   NvimConfig.log_level() == "info"
---  * NEOVIM_TREESITTER_ENABLED="true"  ->   NvimConfig.treesitter_enabled() == true
---
---@param k string: a lowercased neovim env var key w/o the "NEOVIM_" prefix
---@return fun(): string|boolean|nil: a function that returns the string/boolean
--- representation of the env var at "NEOVIM_[upper(k)]", or nil if the env var doesn't
--- exist
function NvimConfig:__index(k)
  k = 'NEOVIM_' .. String.upper(k)
  return Bool.convert_if(Env[k])
end

return NvimConfig.new()

