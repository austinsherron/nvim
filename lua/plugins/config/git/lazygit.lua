local Env = require 'toolbox.system.env'


--- Contains functions for configuring the lazygit plugin.
---
---@class Lazygit
local Lazygit = {}

--- Configures the lazygit plugin.
function Lazygit.config()
  vim.g.lazygit_use_custom_config_file_path = 1
  vim.g.lazygit_config_file_path = Env.config_root_pub() .. '/lazygit/config.yml'
end

return Lazygit

