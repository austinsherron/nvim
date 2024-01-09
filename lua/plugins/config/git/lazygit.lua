local Env = require 'toolbox.system.env'
local Git = require 'utils.api.git'

local globals = vim.g

--- Contains functions for configuring the lazygit plugin.
---
---@class Lazygit
local Lazygit = {}

--- Configures the lazygit plugin.
function Lazygit.config()
  globals.lazygit_use_custom_config_file_path = 1
  globals.lazygit_config_file_path = Env.config_root_pub() .. '/lazygit/config.yml'
  globals.lazygit_floating_window_use_plenary = 1
  globals.lazygit_use_neovim_remote = 1

  Git.Config.set_editor('nvr', '-cc', 'split', '--remote-wait', "+'set bufhidden=wipe'")
end

return Lazygit
