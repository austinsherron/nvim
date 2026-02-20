local Lambda = require 'toolbox.functional.lambda'
local Lsp = require 'utils.api.vim.lsp'
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

local function install_type(packages, type)
  LOGGER:debug('Starting installation check for %s', { type })
  Stream.new(packages):filter(Lambda.NOT(PkgMgr.is_installed)):foreach(PkgMgr.install)
end

--- Checks the installation status of formatters and linters and installs any that are
--- missing.
---
--- TODO: add the ability to specify version numbers, perform automatic upgrades, etc.
---
--- NOTE: lsp server installation is handled by mason-lspconfig's ensure_installed config.
--- This function handles formatters and linters, which mason-lspconfig does not manage.
---
--- WARN: packages removed from manifests are not automatically uninstalled: they must be
--- manually removed through mason.nvim.
function LspManager.install()
  if not NvimConfig.auto_install_packages() then
    local msg = 'Automatic installation disabled: skipping package installation check'
    return LOGGER:warn(msg)
  end

  install_type(LspLibrary.formatters(true), 'formatters')
  install_type(LspLibrary.linters(true), 'linters')
end

--- Entry point to LSP configuration.
function LspManager.init()
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local servers = LspLibrary.servers()

  -- set shared config (capabilities) for all servers
  Lsp.configure('*', { capabilities = capabilities })

  -- apply per-server config overrides
  for _, server in ipairs(servers) do
    local conf = require('lsp.servers.' .. server)

    if not Table.nil_or_empty(conf) then
      Lsp.configure(server, conf)
      LOGGER:debug('Configured server=%s: %s', { server, conf })
    end
  end

  Lsp.enable(servers)
  LspAC.create()
  LspKM.bind_globals()

  LOGGER:info 'Lsp components initialized'
end

return LspManager
