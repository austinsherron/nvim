local Src     = require 'config.cmp.sources'
local LuaSnip = require 'config.luasnip'
local KM      = require 'keymap.plugins.cmp'


--- For internal use: allows us to reference cmp config methods dynamically.
--
---@class _Cmp
local _Cmp = {}

--- Base auto-completion configuration.
--
---@param cmp table: the cmp module
function _Cmp.base(cmp)
  cmp.setup({
    snippet = { expand = LuaSnip.expand },
    mapping = KM.make_mapping(),
    sources = cmp.config.sources({
      Src.buffer(),
      Src.emoji(),
      Src.lsp(),
      Src.lsp_signature(),
      Src.luasnip(),
      Src.path(),
      Src.treesitter(),
    })
  })
end


--- Auto-completion configuration for misc. filetypes.
--
--  Note: if this grows too large, it should be moved to a separate location.
--
---@param cmp table: the cmp module
function _Cmp.filetype(cmp)
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      Src.buffer(),
      Src.git(),
      Src.emoji(),
      Src.path(),
    })
  })
end


--- Auto-completion configuration for the searchline (i.e.: current buffer search -> `/` and `?`)
--  (if native_menu = false).
--
--  Note: I found it rather annoying to have auto-completion in the searchline, so I
--  removed it from the Cmp.config impl by not adding it to _Cmp.
--
---@param cmp table: the cmp module
local function searchline(cmp)
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { Src.buffer(), Src.path() }
  })
end


--- Auto-completion configuration for command line (i.e.: `:`) (if native_menu = false).
--
---@param cmp table: the cmp module
function _Cmp.cmdline(cmp)
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
      { name = 'cmdline' },
    })
  })
end


--- Auto-completion configuration that inserts parens after function names, etc.
--
---@param cmp table: the cmp module
function _Cmp.autopairs(cmp)
  local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  )
end

local Cmp = {}

function Cmp.config()
  -- note: lsp cmp setup happens in nvim:lua/lsp/init.lua
  local cmp = require 'cmp'

  _Cmp.base(cmp)
  _Cmp.filetype(cmp)
  _Cmp.cmdline(cmp)
  _Cmp.autopairs(cmp)
end

return Cmp

