-- note: most of this code, or at least the core logic of it, was sourced from
--       https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#super-tab-like-mapping
local function has_words_before()
  unpack = unpack or table.unpack

  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end


local function make_select_expand_or_complete(cmp, luasnip)
  return function(fallback)
    if (cmp.visible()) then
      cmp.select_next_item()
    -- consider using expand_or_locally_jumpable: that way we only jump inside
    -- the snippet region
    elseif (luasnip.expand_or_jumpable()) then
      luasnip.expand_or_jump()
    elseif has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end
end


local function make_prev_or_contract(cmp, luasnip)
  return function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end
end


local function make_select_with_enter(cmp)
  return function(fallback)
    if cmp.visible() and not cmp.get_active_entry() then
      cmp.select_next_item()
    elseif cmp.visible() and cmp.get_active_entry() then
      cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
    else
      fallback()
    end
  end
end

local Cmp = {}

function Cmp.make_mapping()
  local cmp = require 'cmp'
  local luasnip = require 'luasnip'

  return cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping(make_select_expand_or_complete(cmp, luasnip), { 'i', 's'}),
    ['<S-Tab>'] = cmp.mapping(make_prev_or_contract(cmp, luasnip), { 'i', 's' }),
    ['<CR>'] = cmp.mapping({
      i = make_select_with_enter(cmp),
      s = cmp.mapping.confirm({ select = true }),
      c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
    }),
  })
end

return Cmp

