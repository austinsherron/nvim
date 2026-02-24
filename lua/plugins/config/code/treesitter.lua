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
  SURROUND = 'surround',
  TERRAFORM_DOC = 'terraform-doc',
  TS_RAINBOW = 'rainbow-delimiters.nvim',
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
  [TreesitterPlugin.SURROUND] = true,
  [TreesitterPlugin.TERRAFORM_DOC] = true,
  [TreesitterPlugin.TREESJ] = true,
  [TreesitterPlugin.TS_RAINBOW] = true,
}

local TS_ENABLED = true

--- Languages for which parsers should be installed.
---
---@type string[]
local ENSURE_INSTALLED = {
  'bash',
  'go',
  'gomod',
  'gosum',
  'hcl',
  'javascript',
  'jq',
  'json',
  'just',
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
}

--- Contains functions for configuring the treesitter plugin.
---
---@class Treesitter
local Treesitter = {}

Treesitter.TreesitterPlugin = TreesitterPlugin

--- A central switch to enable/disable treesitter. This is useful for instances
--- in which treesitter or a downstream plugin breaks and needs to be reinstalled:
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

--- Returns the list of languages for which parsers should be installed.
---
---@return string[]: parser languages to ensure are installed
function Treesitter.ensure_installed()
  return ENSURE_INSTALLED
end

--- Configures nvim-treesitter parser installation. Note: as of the nvim-treesitter
--- rewrite, the plugin only manages parser installation; highlighting and indent
--- are provided by neovim's built-in vim.treesitter module and are enabled via
--- autocmd in core/cmd/auto/treesitter.lua.
---
---@param _ table: unused plugin reference
---@param opts table: unused opts (parser installation is handled separately)
function Treesitter.config(_, opts)
  require('nvim-treesitter').install(ENSURE_INSTALLED)
end

return Treesitter
