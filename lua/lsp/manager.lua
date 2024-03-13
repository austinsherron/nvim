local Lambda = require 'toolbox.functional.lambda'
local LspAC = require 'lsp.autocmds'
local LspKM = require 'lsp.keymap'
local LspLibrary = require 'lsp.library'
local PkgMgr = require 'utils.api.packagemgr'

local LOGGER = GetLogger 'LSP'

--- Entry point for configuration and management of neovim LSP servers, formatters, and
--- linters.
---
---@class LspManager
local LspManager = {}

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

  install_type(LspLibrary.servers(), 'lsp servers')
  install_type(LspLibrary.formatters(true), 'formatters')
  install_type(LspLibrary.linters(true), 'linters')
end

--- Entry point to LSP configuration.
function LspManager.init()
  local lspconfig = require 'lspconfig'
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  for _, server in ipairs(LspLibrary.servers()) do
    local conf = get_config_for_server(server, capabilities)
    lspconfig[server].setup(conf)

    LOGGER:debug('Configured server=%s: %s', { server, conf })
  end

  LspAC.create()
  LspKM.bind_globals()

  LOGGER:info 'Lsp components initialized'
end

return LspManager
