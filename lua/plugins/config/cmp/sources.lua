
--- Relative order of completion results in auto-complete menu based on source groups.
--
---@enum GroupIndex
local GroupIndex = {
  LUASNIP       = 1,
  LSP_SIGNATURE = 2,
  LSP           = 3,
  PATH          = 4,
  TREESITTER    = 5,
  BUFFER        = 6,
  GIT           = 7,
  CONVCOMMITS   = 8,
  DICTIONARY    = 9,
  SPELL         = 10,
  EMOJI         = 11,
  CALC          = 12,
}

--- The number of characters to type before including results from specific completion sources.
--
---@enum TriggerLength
local TriggerLength = {
  BUFFER        = 3,
  CALC          = 1,
  CONVCOMMITS   = 2,
  DICTIONARY    = 3,
  EMOJI         = 1,
  GIT           = 2,
  LSP           = 1,
  LSP_SIGNATURE = 1,
  LUASNIP       = 1,
  PATH          = 2,
  SPELL         = 3,
  TREESITTER    = 1,
}

--- Human-readable labels for cmp sources.
--
---@enum SrcLabel
local SrcLabel = {
  ['buffer']              = '[Buffer]',
  ['calc']                = '[Calc]',
  ['conventionalcommits'] = '[CC]',
  ['dictionary']          = '[Dict]',
  ['emoji']               = '[Emoji]',
  ['git']                 = '[Git]',
  ['nvim_lsp']            = '[LSP]',
  ['nvim_lsp_signature']  = '[Sig]',
  ['luasnip']             = '[LuaSnip]',
  ['path']                = '[Path]',
  ['spell']               = '[Spell]',
  ['treesitter']          = '[TS]',
}

local function get_all_bufs()
  return vim.api.nvim_list_bufs()
end

--- Collection of configurations for nvim-cmp completion sources. Also acts as a
--  complete list of installed/configured completion sources.
--
---@class Src
local Src = {}

---@return table: configuration for buffer completion source
function Src.buffer()
  return {
    name           = 'buffer',
    group_index    = GroupIndex.BUFFER,
    max_item_count = 5,
    trigger_length = TriggerLength.BUFFER,

    option = {
      get_bufnrs = get_all_bufs,
    }
  }
end


---@return table: configuration for calc (math-y type stuff) completion source
function Src.calc()
  return {
    name           = 'calc',
    group_index    = GroupIndex.CALC,
    max_item_count = 5,
    trigger_length = TriggerLength.CALC,
  }
end


-- TODO: set this up
---@return table: configuration for conventional commits (i.e.: standard commit message
-- terms) completion source
local function conventionalcommits()
  return {
    name           = 'conventionalcommits',
    group_index    = GroupIndex.CONVCOMMITS,
    max_item_count = 5,
    trigger_length = TriggerLength.CONVCOMMITS,
  }
end


-- TODO: set this up
---@return table: configuration for dictionary completion source
function Src.dictionary()
  return {
    name           = 'dictionary',
    group_index    = GroupIndex.DICTIONARY,
    max_item_count = 5,
    trigger_length = TriggerLength.DICTIONARY,
  }
end


---@return table: configuration for emoji completion source
function Src.emoji()
  return {
    name           = 'emoji',
    group_index    = GroupIndex.EMOJI,
    max_item_count = 5,
    trigger_length = TriggerLength.EMOJI,
  }
end


---@return table: configuration for git completion source
function Src.git()
  return {
    name           = 'git',
    group_index    = GroupIndex.GIT,
    max_item_count = 5,
    trigger_length = TriggerLength.GIT,
  }
end


---@return table: configuration for lsp completion source
function Src.lsp()
  return {
    name           = 'nvim_lsp',
    group_index    = GroupIndex.LSP,
    max_item_count = 5,
    trigger_length = TriggerLength.LSP,
  }
end


---@return table: configuration for lsp signature completion source
function Src.lsp_signature()
  return {
    name           = 'nvim_lsp_signature',
    group_index    = GroupIndex.LSP_SIGNATURE,
    max_item_count = 5,
    trigger_length = TriggerLength.LSP_SIGNATURE,
  }
end


---@return table: configuration for luasnip (snippets engine) completion source
function Src.luasnip()
  return {
    name           = 'luasnip',
    group_index    = GroupIndex.LUASNIP,
    max_item_count = 5,
    trigger_length = TriggerLength.LUASNIP,
  }
end


---@return table: configuration for file-system path completion source
function Src.path()
  return {
    name           = 'path',
    group_index    = GroupIndex.PATH,
    max_item_count = 5,
    trigger_length = TriggerLength.PATH,
  }
end


-- TODO: set this up
---@return table: configuration for spellcheck suggestions completion source
function Src.spell()
  return {
    name           = 'spell',
    group_index    = GroupIndex.SPELL,
    max_item_count = 5,
    trigger_length = TriggerLength.SPELL,
  }
end


-- TODO: set this up
---@return table: configuration for treesitter completion source
function Src.treesitter()
  return {
    name           = 'treesitter',
    group_index    = GroupIndex.TREESITTER,
    max_item_count = 5,
    trigger_length = TriggerLength.TREESITTER,
  }
end


--- Returns the user facing labels for known cmp sources. For use in cmp formatting
--  config.
--
---@return { [string]: string }: a table that maps cmp sources to their labels
function Src.get_labels()
  return SrcLabel
end

return Src

