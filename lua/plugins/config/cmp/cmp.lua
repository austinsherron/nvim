local km = require 'nvim.lua.config.keymappings.plugins.cmp'
local ls = require 'nvim.lua.plugins.config.luasnip'
local lsp = require 'nvim.lua.config.lsp'
local src = require 'nvim.lua.plugins.config.cmp.sources'

-- base config -----------------------------------------------------------------

local function base(cmp)
  cmp.setup({
    snippet = { expand = ls.expand, },
    mapping = km.make_mapping(),
    sources = cmp.config.sources(src.all())
  })
end

-- file type specific config ---------------------------------------------------

local function filetype(cmp)
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({ src.buffer(), src.git() })
  })
end

-- search config ---------------------------------------------------------------

-- buffer source for `/` and `?` (if native_menu = false)
local function searchline(cmp)
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = { src.buffer(), src.path() }
  })
end

-- cmd config ------------------------------------------------------------------

-- cmdline + path sources for `:` (if native_menu = false)
local function cmdline(cmp)
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
      { name = 'cmdline' },
    })
  })
end

local Cmp = {}

function Cmp.config()
  -- note: lsp cmp setup happens in nvim:lua/config/lsp/init.lua
  local cmp = require 'cmp'

  base(cmp)
  filetype(cmp)
  searchline(cmp)
  cmdline(cmp)
end

return Cmp

