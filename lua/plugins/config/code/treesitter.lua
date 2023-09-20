local Env = require 'toolbox.system.env'


--- Strongly-typed representation of plugins w/ a dependency on treesitter.
---
---@enum TreesitterPlugin
local TreesitterPlugin = {
  AERIAL           = 'aerial',
  AUTOPAIRS        = 'autopairs',
  CMP_TREESITTER   = 'cmp-treesitter',
  ENDWISE          = 'endwise',
  INDENT_BLANKLINE = 'indent-blankline',
  NEOGEN           = 'neogen',
  PLAYGROUND       = 'playground',
  TS_RAINBOW       = 'ts-rainbow2',
  TREESJ           = 'treesj',
}

local TS_PLUGIN_ENABLEMENT = {
  [TreesitterPlugin.AERIAL]           = false,
  [TreesitterPlugin.AUTOPAIRS]        = false,
  [TreesitterPlugin.CMP_TREESITTER]   = false,
  [TreesitterPlugin.ENDWISE]          = false,
  [TreesitterPlugin.INDENT_BLANKLINE] = false,
  [TreesitterPlugin.NEOGEN]           = false,
  [TreesitterPlugin.PLAYGROUND]       = false,
  [TreesitterPlugin.TS_RAINBOW]       = false,
  [TreesitterPlugin.TREESJ]           = false,
}

local TS_ENABLED = false

--- Contains functions for configuring the treesitter plugin.
---
---@class Treesitter
local Treesitter = {}

Treesitter.TreesitterPlugin = TreesitterPlugin

--- A central switch to enable/disable treesitter. This is useful for instances
--- in which treesitter or a downstream plugin breaks and needs to be reinstalled,
--- something that has been happening fairly frequently at the time of writing
--- (09/14/2023).
---
---@param plugin TreesitterPlugin|nil: if provided, checks the individual treesitter
--- plugin's enablement; if nil, returns the enablement of treesitter generally
---@return boolean: if true, nvim-treesitter and downstream plugins are
--- enabled and usable (in theory)
function Treesitter.enabled(plugin)
  if TS_ENABLED == false or plugin == nil then
    return TS_ENABLED
  end

  return TS_PLUGIN_ENABLEMENT[plugin]
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
      'yaml',
    },
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

