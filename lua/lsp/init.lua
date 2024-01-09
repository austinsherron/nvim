local Env = require 'toolbox.system.env'
local LspAC = require 'lsp.autocmds'
local LspKM = require 'lsp.keymap'
local Path = require 'toolbox.system.path'
local Shell = require 'toolbox.system.shell'

local LOGGER = GetLogger 'LSP'
local SERVERS_PATH = Env.nvim_root() .. '/lua/lsp/servers'

--- Configures neovim LSP and related functionality.
---
---@class Lsp
local Lsp = {}

---@return string[]: an array-like table w/ configured lsp servers
function Lsp.servers()
  return map(Shell.ls(SERVERS_PATH), Path.trim_extension)
end

local function get_config_for_server(lsp_server, capabilities)
  local server_conf = require('lsp.servers.' .. lsp_server)

  -- TODO: figure out how to better organize code so plugin specific lsp conf doesn't
  --       need to be centralized here
  local cmp_conf = { capabilities = capabilities }

  return Table.combine_many({ cmp_conf, server_conf })
end

--- Entry point to LSP configuration.
function Lsp.config()
  local lspconfig = require 'lspconfig'
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  for _, server in ipairs(Lsp.servers()) do
    local conf = get_config_for_server(server, capabilities)
    lspconfig[server].setup(conf)

    LOGGER:debug('Configured server=%s: %s', { server, conf })
  end

  LspAC.create()
  LspKM.bind_globals()
end

return Lsp
