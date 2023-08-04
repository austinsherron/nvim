local Env = require 'lib.lua.system.env'


--- Contains functions for configuring the treesitter plugin.
---
---@class Treesitter
local Treesitter = {}

---@return table: build (install/update workflow) opts for treesitter plugin
function Treesitter.build()
  return { with_sync = true }
end


---@return table: configures the treesitter plugin
function Treesitter.opts()
  return {
    -- parser install options
    auto_install = false,
    -- TODO: figure out why treesitter installs these every time nvim is started
    -- ensure_installed = {
    --   'bash',
    --   'go',
    --   'gomod',
    --   'gosum',
    --   'hcl',
    --   'help',
    --   'javascript',
    --   'json',
    --   'lua',
    --   'markdown',
    --   'python',
    --   'query',
    --   'sql',
    --   'terraform',
    --   'typescript',
    --   'vim',
    --   'yaml'
    -- },
    ignore_install = {},
    parser_install_dir = Env.nvundle(),
    sync_install = false,

    -- features
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
    endwise = {
      enable = true,
    },
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
    rainbow = {
      enable = true,
    },
  }
end

return Treesitter

