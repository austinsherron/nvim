local Env = require 'toolbox.system.env'


local TS_ENABLED = false

--- Contains functions for configuring the treesitter plugin.
---
---@class Treesitter
local Treesitter = {}

--- A central switch to enable/disable treesitter. This is useful for instances
--- in which treesitter or a downstream plugin breaks and needs to be reinstalled,
--- something that has been happening fairly frequently at the time of writing
--- (09/14/2023).
---
---@return boolean: if true, nvim-treesitter and downstream plugins are
--- enabled and usable (in theory)
function Treesitter.enabled()
  return TS_ENABLED
end


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
    --   'yaml',
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

