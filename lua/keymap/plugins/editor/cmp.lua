
-- note: most of this code, or at least the core logic of it, was sourced from
--       https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#super-tab-like-mapping
local function has_words_before()
  local line, col = Table.unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end


--- Mapping function for <Tab>. Its logic:
---
---   1) if the completion menu is visible, select the next item
---   2) if item is a luasnip, expand it or jump to next insertion point
---   3) if there are characters before the cursor, complete the
---   4) else fallback
local function make_select_expand_or_complete(cmp, luasnip)
  return function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.expand_or_locally_jumpable() then
      luasnip.expand_or_jump()
    elseif has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end
end


--- Mapping function for <S-Tab>. Its logic:
---
---   1) if the completion menu is visible, select the previous item
---   2) if the item is a luasnip and the last item is jumpable, jump to it
---   3) else fallback
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


local function make_change_choice(direction, luasnip)
  return function(fallback)
    if luasnip.choice_active() then
      luasnip.change_choice(direction)
    else
      fallback()
    end
  end
end


local function make_next_choice(luasnip)
  return make_change_choice(1, luasnip)
end


local function make_prev_choice(luasnip)
  return make_change_choice(-1, luasnip)
end


---  Mapping function for <CR>. Its logic:
---
---   1) if the completion menu is visible and there's an active entry, confirm
---   2) else fallback
---
local function make_select_with_enter(cmp)
  return function(fallback)
    if cmp.visible() and cmp.get_active_entry() then
      cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
    else
      fallback()
    end
  end
end


local function make_close_cmp_menu(cmp)
  return function(fallback)
    if cmp.visible() then
      cmp.close()
    else
      fallback()
    end
  end
end

--- Contains methods for configuring key bindings for auto-completion (nvim-cmp).
---
---@class Cmp
local Cmp = {}

--- Creates the keymap for auto-completion (nvim-cmp).
---
---@return table: the nvim-cmp keymap
function Cmp.make_mapping()
  local cmp = require 'cmp'
  local luasnip = require 'luasnip'

  return cmp.mapping.preset.insert({
    ['<Tab>']   = cmp.mapping(make_select_expand_or_complete(cmp, luasnip), { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(make_prev_or_contract(cmp, luasnip),          { 'i', 's' }),
    ['<Down>']  = cmp.mapping(make_next_choice(luasnip),                    { 'i', 's' }),
    ['<Up>']    = cmp.mapping(make_prev_choice(luasnip),                    { 'i', 's' }),
    ['<C-x>']   = cmp.mapping(make_close_cmp_menu(cmp),                     { 'i', 's' }),
    ['<CR>']    = cmp.mapping({
      i = make_select_with_enter(cmp),
      s = cmp.mapping.confirm({ select = true }),
      c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
    }),
  })
end

return Cmp

