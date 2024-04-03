local Buffer = require 'utils.api.vim.buffer'

local LOGGER = GetLogger 'CMP'

---@note: used to compute group_index; a src's place in the array is its relative ordering
--- in completion results
local ORDER = {
  'nvim_lsp_signature_help',
  'nvim_lsp',
  'nvim_lua',
  'path',
  'cmdline',
  'treesitter',
  'buffer',
  'conventionalcommits',
  'dictionary',
  'spell',
  'emoji',
  'calc',
}

--- Contains nvim-cmp configuration for an individual source.
---
---@note: reference ':h cmp-config.sources' for field descriptions
---
---@class CmpSrc
---@field private setup { name: string, config: table }|nil
local CmpSrc = {}
CmpSrc.__index = CmpSrc

function CmpSrc.new(name, label, trigger_length, options, setup)
  return setmetatable({
    name = name,
    label = label,
    group_index = Array.indexof(ORDER, name),
    trigger_length = trigger_length,
    option = options,
    setup = setup,
  }, CmpSrc)
end

---@private
function CmpSrc:setup_if_necessary()
  if self.setup == nil then
    return
  end

  local name = self.setup.name
  local config = self.setup.config or {}

  LOGGER:trace('Calling setup for src=%s w/ config=%s', { name, config })

  require(name).setup(config)
end

--- Custom call metamethod that uses the instance to construct a "source" table in the
--- format expected by cmp.
---
---@return table: a "source" table in the format expected by cmp
function CmpSrc:__call()
  -- label isn't needed (or expected) here
  local config = Table.pick_out(self, Set.of('label', 'setup'))
  -- hard coding this for now
  config.max_item_count = 5

  LOGGER:trace('Configuring src=%s, config=%s', { config.name, config })
  self:setup_if_necessary()

  return config
end

---@note: as suggested by ':h cmp-spell-enable-in-context'
local function enable_spell()
  return require('cmp.config.context').in_treesitter_capture 'spell'
end

local DISABLED_CMDS = Set.of('e', 'IncRename', 'split', 'vsp', 'vsplit')

---@enum Source
local Source = {
  BUFFER = CmpSrc.new('buffer', '[Buffer]', 3, { get_bufnrs = Buffer.getall }),
  CALC = CmpSrc.new('calc', '[Calc]', 1),
  CMDLINE = CmpSrc.new('cmdline', '[Cmd]', 3, { ignore_cmds = DISABLED_CMDS }),
  CONVCOMMITS = CmpSrc.new('conventionalcommits', '[CC]', 2),
  DICTIONARY = CmpSrc.new('dictionary', '[Dict]', 3),
  EMOJI = CmpSrc.new('emoji', '[Emoji]', 1),
  GIT = CmpSrc.new('git', '[Git]', 1, nil, { name = 'cmp_git' }),
  LSP = CmpSrc.new('nvim_lsp', '[LSP]', 1),
  LSP_SIGNATURE = CmpSrc.new('nvim_lsp_signature_help', '[Sig]', 1),
  LUASNIP = CmpSrc.new('luasnip', '[LuaSnip]', 1),
  NVIM_LUA = CmpSrc.new('nvim_lua', '[NvimLua]', 3),
  PATH = CmpSrc.new('path', '[Path]', 2),
  SPELL = CmpSrc.new('spell', '[Spell]', 3, { enable_in_context = enable_spell }),
  TREESITTER = CmpSrc.new('treesitter', '[TS]', 1),
}

--- Collection of configurations for nvim-cmp completion sources. Also acts as a
--- complete list of installed/configured completion sources.
---
---@class Src
local Src = {}

local LABELS = Table.to_dict(Table.values(Source), function(e)
  return e.name, e.label
end)

---@note: order here informs the order of auto-complete results
---@return table[]: configuration for sources used by base cmp setup
function Src.for_base()
  return {
    Source.LUASNIP(),
    Source.LSP(),
    Source.LSP_SIGNATURE(),
    Source.NVIM_LUA(),
    Source.PATH(),
    Source.TREESITTER(),
    Source.SPELL(),
    Source.DICTIONARY(),
    Source.BUFFER(),
    Source.EMOJI(),
  }
end

---@note: order here informs the order of auto-complete results
---@return table[]: configuration for sources used in git commits
function Src.for_gitcommit()
  return {
    Source.GIT(),
    Source.PATH(),
    Source.BUFFER(),
    Source.NVIM_LUA(),
    Source.EMOJI(),
    Source.SPELL(),
    Source.DICTIONARY(),
  }
end

---@return table[]: configuration for sources used in the vim command line
function Src.for_cmdline()
  return {
    Source.CMDLINE(),
    Source.PATH(),
  }
end

--- Returns the user facing labels for known cmp sources. For use in cmp formatting
--- config.
---
---@return { [string]: string }: a table that maps cmp sources to their labels
function Src.get_labels()
  return LABELS
end

return Src
