--- Strongly-typed representation of plugins w/ a dependency on treesitter.
---
---@enum TreesitterPlugin
local TreesitterPlugin = {
  AUTOPAIRS = 'autopairs',
  CMP_TREESITTER = 'cmp-treesitter',
  ENDWISE = 'endwise',
  INDENT_BLANKLINE = 'indent-blankline',
  NEOGEN = 'neogen',
  NEOTEST = 'neotest',
  NOICE = 'noice',
  PLAYGROUND = 'playground',
  SURROUND = 'surround',
  TS_RAINBOW = 'ts-rainbow2',
  TREESJ = 'treesj',
}

local TS_PLUGIN_ENABLEMENT = {
  [TreesitterPlugin.AUTOPAIRS] = true,
  [TreesitterPlugin.CMP_TREESITTER] = true,
  [TreesitterPlugin.ENDWISE] = true,
  [TreesitterPlugin.INDENT_BLANKLINE] = true,
  [TreesitterPlugin.NEOGEN] = true,
  [TreesitterPlugin.NEOTEST] = true,
  [TreesitterPlugin.NOICE] = true,
  [TreesitterPlugin.PLAYGROUND] = true,
  [TreesitterPlugin.SURROUND] = true,
  [TreesitterPlugin.TREESJ] = true,
  [TreesitterPlugin.TS_RAINBOW] = true,
}

local TS_ENABLED = true

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
  -- if no plugin is provided, just check if ts is enabled, otherwise check the plugin
  return TS_ENABLED and (plugin == nil or TS_PLUGIN_ENABLEMENT[plugin])
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
    ensure_installed = {
      'bash',
      'go',
      'gomod',
      'gosum',
      'hcl',
      'javascript',
      'jq',
      'json',
      'lua',
      'markdown',
      'markdown_inline',
      'python',
      'regex',
      'query',
      'sql',
      'terraform',
      'toml',
      'typescript',
      'vim',
      'vimdoc',
      'yaml',
    },
    ignore_install = {},
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
