local env = require 'lib.lua.system.env'


--- Contains functions for configuring the treesitter plugin.
--
---@class Treesitter
local Treesitter = {}

---@return table: build opts for treesitter plugin
function Treesitter.build()
  return {
    with_sync = true,
    ensure_installed = {
      'bash',
      'go',
      'gomod',
      'gosum',
      'hcl',
      'help',
      'javascript',
      'json',
      'lua',
      'markdown',
      'python',
      'query',
      'sql',
      'terraform',
      'typescript',
      'vim',
      'yaml'
    },
  }
end


---@return table: configures the treesitter plugin
function Treesitter.opts()
  return {
    auto_install = false,

    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },

    ignore_install = {},
    parser_install_dir = env.nvundle(),
    sync_install = false,
  }
end

return Treesitter

