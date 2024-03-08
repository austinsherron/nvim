local Env = require 'toolbox.system.env'
local Lambda = require 'toolbox.functional.lambda'
local LspAC = require 'lsp.autocmds'
local LspKM = require 'lsp.keymap'
local Path = require 'toolbox.system.path'
local PkgMgr = require 'utils.api.packagemgr'
local Shell = require 'toolbox.system.shell'

local LOGGER = GetLogger 'LSP'
local SERVERS_PATH = Env.nvim_root_pub() .. '/lua/lsp/servers'

local FORMATTERS = {
  go = { 'gci', 'gofumpt' },
  lua = { 'stylua' },
  python = { 'black', 'isort' },
  -- FIXME: not working the way I want it to
  -- sh = { 'shfmt' },
  -- TODO: no OOB efmls config
  yaml = { 'yamlfmt' },
}

local LINTERS = {
  go = { 'golangci-lint' },
  lua = { 'luacheck' },
  python = { 'pylint' },
  sh = { 'shellharden' },
  tf = { 'tflint' },
  -- yaml = { 'yamllint' },
}

--- Entry point for configuration and management of neovim LSP servers, formatters, and
--- linters.
---
---@class LspManager
local LspManager = {}

---@return string[]: an array-like table w/ configured lsp servers
function LspManager.servers()
  return map(Shell.ls(SERVERS_PATH), Path.trim_extension)
end

local function get_components(components, namesonly)
  if namesonly ~= true then
    return components
  end

  return Stream.new(Table.values(components)):flatmap(Lambda.IDENTITY):collect()
end

--- Gets the manifest of formatters.
---
---@param namesonly boolean|nil: optional, defaults to false; if true, returns an array of
--- formatter names instead of a map of languages -> formatters
---@return { [string]: string[] }|string[]: a map of languages to formatters, or an array
--- of formatter names, depending on the value of namesonly
function LspManager.formatters(namesonly)
  return get_components(FORMATTERS, namesonly)
end

--- Gets the manifest of linters.
---
---@param namesonly boolean|nil: optional, defaults to false; if true, returns an array of
--- linter names instead of a map of languages -> linters
---@return { [string]: string[] }|string[]: a map of languages to linters, or an array
--- of linter names, depending on the value of namesonly
function LspManager.linters(namesonly)
  return get_components(LINTERS, namesonly)
end

local function get_config_for_server(lsp_server, capabilities)
  local server_conf = require('lsp.servers.' .. lsp_server)

  -- TODO: figure out how to better organize code so plugin specific lsp conf doesn't
  --       need to be centralized here
  local cmp_conf = { capabilities = capabilities }

  return Table.combine_many({ cmp_conf, server_conf })
end

local function install_type(packages, type)
  LOGGER:debug('Starting installation check for %s', { type })
  Stream.new(packages):filter(Lambda.NOT(PkgMgr.is_installed)):foreach(PkgMgr.install)
end

--- Checks the installation status of the current manifest of language components and
--- installs any that are missing.
---
--- TODO: add the ability to specify version numbers, perform automatic upgrades, etc.
---
--- NOTE: the mason.nvim plugin provides the ability to specify lsp servers for automatic
--- installation, but no other types of language component. This works around that
--- limitation.
---
--- WARN: packages removed from manifests are not automatically uninstalled: they must be
--- manually removed through mason.nvim.
function LspManager.install()
  if not NvimConfig.auto_install_packages() then
    local msg = 'Automatic installation disabled: skipping package installation check'
    return LOGGER:warn(msg)
  end

  install_type(LspManager.servers(), 'lsp servers')
  install_type(LspManager.formatters(true), 'formatters')
  install_type(LspManager.linters(true), 'linters')
end

--- Entry point to LSP configuration.
function LspManager.init()
  local lspconfig = require 'lspconfig'
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  for _, server in ipairs(LspManager.servers()) do
    local conf = get_config_for_server(server, capabilities)
    lspconfig[server].setup(conf)

    LOGGER:debug('Configured server=%s: %s', { server, conf })
  end

  LspAC.create()
  LspKM.bind_globals()

  LOGGER:info 'Lsp components initialized'
end

return LspManager
