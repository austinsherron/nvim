local LspKind = require 'lspkind'
local KM      = require 'keymap.plugins.editor.cmp'
local Src     = require 'plugins.config.editor.cmp.sources'
local LuaSnip = require 'plugins.config.code.luasnip'
local Editor  = require 'utils.api.vim.editor'


local CMDLINE_DISABLED_CMDS = Set.new({
  'IncRename',
  'e',
  'split',
  'vsp',
  'vsplit',
})

--- For internal use: allows us to reference cmp config methods dynamically.
---
---@class _Cmp
local _Cmp = {}

--- Base auto-completion configuration.
---
---@param cmp table: the cmp module
function _Cmp.base(cmp)
  cmp.setup({
    formatting = {
      format = LspKind.cmp_format({
        mode = 'symbol_text',
        menu = Src.get_labels(),
      }),
    },
    snippet = { expand = LuaSnip.expand },
    mapping = KM.make_mapping(),
    -- note: order here informs the order of auto-complete results
    sources = cmp.config.sources({
      Src.luasnip(),
      Src.lsp(),
      Src.lsp_signature(),
      Src.path(),
      Src.treesitter(),
      Src.dictionary(),
      Src.buffer(),
      Src.emoji(),
    })
  })
end


--- Auto-completion configuration for misc. filetypes.
---
--- Note: if this grows too large, it should be moved to a separate location.
---
---@param cmp table: the cmp module
function _Cmp.filetype(cmp)
  cmp.setup.filetype('gitcommit', {
    -- note: order here informs the order of auto-complete results
    sources = cmp.config.sources({
      Src.git(),
      Src.path(),
      Src.buffer(),
      Src.emoji(),
    })
  })
end


--- Auto-completion configuration for the searchline (i.e.: current buffer search -> `/` and `?`)
--- (if native_menu = false).
---
--- Note: I found it rather annoying to have auto-completion in the searchline, so I've
--- disabled it until further notice.
--
---@param cmp table: the cmp module
function _Cmp.searchline(cmp)
  cmp.setup.cmdline({ '/', '?' }, {
    enabled = false,
    mapping = cmp.mapping.preset.cmdline(),
    sources = { Src.buffer(), Src.path() }
  })
end


local function should_complete_cmdline()
  local cmd = String.firstword(Editor.cmdline())

  DebugQuietly({ '_Cmp.should_complete_cmdline: cmd=', cmd })

  return not CMDLINE_DISABLED_CMDS:contains(cmd)
end


--- Auto-completion configuration for command line (i.e.: `:`) (if native_menu = false).
---
---@param cmp table: the cmp module
function _Cmp.cmdline(cmp)
  cmp.setup.cmdline(':', {
    enabled = should_complete_cmdline,
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'cmdline' },
      { name = 'path' },
    })
  })
end


--- Auto-completion configuration that inserts parens after function names, etc.
---
---@param cmp table: the cmp module
function _Cmp.autopairs(cmp)
  local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  )
end

--- Contains functions for configuring the nvim-cmp plugin.
---
---@class Cmp
local Cmp = {}

--- Configures the nvim-cmp plugin.
function Cmp.config()
  -- note: lsp cmp setup happens in nvim:lua/lsp/init.lua
  local cmp = require 'cmp'

  _Cmp.base(cmp)
  _Cmp.filetype(cmp)
  _Cmp.searchline(cmp)
  _Cmp.cmdline(cmp)
  _Cmp.autopairs(cmp)
end

return Cmp

