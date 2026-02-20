local Grammar = require 'toolbox.utils.grammar'

local mason_registry = Lazy.require 'mason-registry' ---@module 'mason-registry'

local LOGGER = GetLogger 'LSP'

--- Language component package manager API. Language components include lsp servers,
--- linters, formatters, etc. At the time of writing, this is a wrapper around
--- the mason.nvim language component package manager plugin.
---
--- NOTE: lsp server installation is handled by mason-lspconfig's ensure_installed
--- config. This module is used for formatters and linters, whose names are already
--- mason-compatible.
---
---@class PackageManager
local PackageManager = {}

--- Checks if the mason package w/ the provided name is installed.
---
--- WARN: false can indicate either that the component isn't installed, or that mason
--- isn't aware of a component w/ the provided name.
---
---@param name string: the name of the component to check for installation
---@return boolean: true if the provided component is installed, false otherwise (or if
--- the component is unknown to mason)
function PackageManager.is_installed(name)
  local is_installed = mason_registry.is_installed(name)

  local is_or_not = Grammar.is_or_not(is_installed)
  LOGGER:debug('Mason package=%s %s installed', { name, is_or_not })

  return is_installed
end

--- Install the package w/ the provided name, if it exists.
---
--- WARN: this function performs installation work regardless of installation status. Take
--- care to filter out installed packages w/ PackageManager.is_installed if that's the
--- desired behavior.
---
---@param name string: the name of the package to install
function PackageManager.install(name)
  local cmd = 'MasonInstall ' .. name

  LOGGER:info('Installing mason component=%s', { name })
  Safe.call(vim.api.nvim_command, {}, cmd)
end

return PackageManager
