-- internal
local CmpKM   = require 'keymap.plugins.editor.cmp'
local Src     = require 'plugins.config.editor.cmp.sources'
local LuaSnip = require 'plugins.config.code.luasnip'
local Editor  = require 'utils.api.vim.editor'

-- external
local lspkind = require 'lspkind'


local LOGGER = GetLogger('CMP')
local CMDLINE_DISABLED_CMDS = Set.of('ls')

--- Contains functions for configuring the nvim-cmp plugin.
---
---@class Cmp
local Cmp = {}

---@private
function Cmp.formatting()
  return {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      menu = Src.get_labels(),
    }),
  }
end


--- Base auto-completion configuration.
---
---@param cmp table: the cmp module
function Cmp.base(cmp)
  LOGGER:debug('Configuring base')

  cmp.setup({
    formatting = Cmp.formatting(),
    mapping    = CmpKM.make_mapping(),
    sources    = cmp.config.sources(Src.for_base()),
    snippet    = { expand = LuaSnip.expand },
  })
end


--- Auto-completion configuration for misc filetypes.
---
---@param cmp table: the cmp module
function Cmp.filetype(cmp)
  LOGGER:debug('Configuring filetypes')

  cmp.setup.filetype('gitcommit', {
    formatting = Cmp.formatting(),
    mapping    = CmpKM.make_mapping(),
    sources    = cmp.config.sources(Src.for_gitcommit()),
  })
end


-- FIXME: this doesn't seem to work they way I want it to (or think/thought it should)
local function should_complete_cmdline()
  local cmd = Editor.cmdline()
  local firstword = String.firstword(cmd)

  if CMDLINE_DISABLED_CMDS:contains(firstword) then
    LOGGER:debug('Cmdline completion disabled for cmd=%s', { cmd })
    return false
  end

  return true
end


--- Auto-completion configuration for command line (i.e.: `:`) (if native_menu = false).
---
---@param cmp table: the cmp module
function Cmp.cmdline(cmp)
  LOGGER:debug('Configuring cmdline')

  cmp.setup.cmdline(':', {
    enabled = should_complete_cmdline,
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(Src.for_cmdline()),
  })
end


--- Auto-completion configuration that inserts parens after function names, etc.
---
---@param cmp table: the cmp module
function Cmp.autopairs(cmp)
  LOGGER:debug('Configuring autopairs')

  local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  )
end


--- Primary entry point to configuring nvim-cmp.
---@note: lsp cmp setup happens in nvim:lua/lsp/init.lua
function Cmp.config()
  LOGGER:info('Starting configuration')

  local cmp = require 'cmp'

  Cmp.base(cmp)
  Cmp.filetype(cmp)
  Cmp.cmdline(cmp)
  Cmp.autopairs(cmp)
end

return Cmp

