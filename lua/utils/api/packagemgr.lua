local Grammar = require 'toolbox.utils.grammar'

local mason_lspconfig = Lazy.require 'mason-lspconfig' ---@module 'mason-lspconfig'
local mason_registry = Lazy.require 'mason-registry' ---@module 'mason-registry'

local LOGGER = GetLogger 'LSP'
local NAME_MAPPINGS = mason_lspconfig.get_mappings()

--- Language component package manager API. Language components include lsp servers,
--- linters, formatters, etc. At the time of writing, this is a wrapper around
--- the mason.nvim language component package manager plugin.
---
---@class PackageManager
local PackageManager = {}

local function get_name(name, mappings, strict)
  strict = strict or false
  local mapped = mappings[name]

  if strict and mapped == nil then
    Err.raise('PackageManager.get_name: no mapping found for name=%s', name)
  end

  return mapped
end

--- Gets the package name that maps to the provided lsp config name. For context: the
--- names of components according to package managers can sometimes differ from the names
--- of the same components according to nvim-lspconfig.
---
---@param lspconfig_name string: the name of the lsp config component
---@param strict boolean|nil: optional, defaults to false; if true, the method will raise
--- an error if no package name is found for the provided lsp config name
---@return string|nil: the package name that maps to the provided lsp config name, or nil
--- if none is found and strict is falsy
---@error if strict is true and no package name is found for the provided lsp config name
function PackageManager.package_name(lspconfig_name, strict)
  return get_name(lspconfig_name, NAME_MAPPINGS.lspconfig_to_mason, strict)
end

--- Gets the lsp config name that maps to the provided package name. For context: the
--- names of components according to package managers can sometimes differ from the names
--- of the same components according to nvim-lspconfig.
---
---@param package_name string: the name of the package
---@param strict boolean|nil: optional, defaults to false; if true, the method will raise
--- an error if no lsp config name is found for the provided package name
---@return string|nil: the lsp config name that maps to the provided package name, or nil
--- if none is found and strict is falsy
---@error if strict is true and no lsp config name is found for the provided package name
function PackageManager.lspconfig_name(package_name, strict)
  return get_name(package_name, NAME_MAPPINGS.mason_to_lspconfig, strict)
end

--- Checks if the mason package w/ the provided lsp config name is installed. This
--- function initially checks installation status using the lsp config's package name, if
--- one is available. Otherwise, it falls back to the provided lsp config name.
---
--- WARN: false can indicate either that the component isn't installed, or that mason
--- isn't aware of a component w/ the provided name/mapped package name.
---
---@param lspconfig_name string: the name of the component to check for installation
---@return boolean: true if the provided component is installed, false otherwise (or if
--- the component is unknown to mason)
function PackageManager.is_installed(lspconfig_name)
  local package_name = PackageManager.package_name(lspconfig_name)
  -- fall back to lspconfig_name if we can't find a package name
  local is_installed = mason_registry.is_installed(package_name or lspconfig_name)

  local is_or_not = Grammar.is_or_not(is_installed)
  LOGGER:debug('Mason package=%s %s installed', { package_name, is_or_not })

  return is_installed
end

--- Install the package w/ the provided lsp config name, if it exists.
---
--- WARN: this function performs installation work regardless of installation status. Take
--- care to filter out installed packages w/ PackageManager.is_installed if that's the
--- desired behavior.
---
---@param lspconfig_name string: the lsp config name of the package to install
function PackageManager.install(lspconfig_name)
  local package_name = PackageManager.package_name(lspconfig_name)
  -- fall back to lspconfig_name if we can't find a package name
  local cmd = 'MasonInstall ' .. (package_name or lspconfig_name)

  LOGGER:info('Installing mason component=%s', { package_name })
  Safe:call(vim.api.nvim_command, {}, cmd)
end

return PackageManager
