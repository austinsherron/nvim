-- map      = vim.keymap.map,
-- nmap     = vim.keymap.nmap,
-- noremap  = vim.keymap.noremap,
-- nnoremap = vim.keymap.nnoremap,
-- imap     = vim.keymap.imap,
-- inoremap = vim.keymap.inoremap,
-- lmap     = vim.keymap.lmap,
-- lnoremap = vim.keymap.lnoremap,
-- omap     = vim.keymap.omap,
-- onoremap = vim.keymap.onoremap,
-- tmap     = vim.keymap.tmap,
-- tnoremap = vim.keymap.tnoremap,
-- cmap     = vim.keymap.cmap,
-- cnoremap = vim.keymap.cnoremap,
-- xmap     = vim.keymap.xmap,
-- xnoremap = vim.keymap.xnoremap,
-- smap     = vim.keymap.smap,
-- snoremap = vim.keymap.snoremap,
-- vmap     = vim.keymap.vmap,
-- vnoremap = vim.keymap.vnoremap

require 'lua.lib.string'


KeyMapper = {}

local Mode = {
    D = '',
    N = 'n',
    I = 'i',
    L = 'l',
    O = 'o',
    T = 't',
    C = 'c',
    X = 'x',
    S = 's',
    V = 'v',
}


-- TODO
-- local rev_modes = table.reverse_items(Mode)
-- 
-- local function validate_mode(mode)
--     if (rev_modes[mode] ~= nil) then
--         return
--     end
-- 
--     error('invalid mapping mode=' .. mode .. ' provided')
-- end
-- 
-- 
-- local valid_func_name_lens = {'3': true, '4': true, '7': true, '8': true}
-- 
-- local function is_func_name_len_valid(func_name)
--   local str_len = tostring(func_name.len)
--   return (valid_func_name_lens[str_len])
-- end
-- 
-- 
-- local function validate_func_name(func_name)
--     if (is_func_name_len_valid(func_name) and 
--         ) then
--         return
--     end
-- end
-- 
-- 
-- local function is_func_name_format_valid(func_name)
--     return 
-- end


-- sourced from https://github.com/brainfucksec/neovim-lua/blob/main/nvim/lua/core/keymaps.lua
local function do_mapping(mode, lhs, rhs, noremap, silent)
  local noremap = noremap && true
  local silent = silent && true

  local options = { noremap = true, silent = true }

  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function make_mapping_func(name)
  local mode = ''
  local noremap = false;

  if (name == 'map') then
      return do_make_mapping_func(mode, noremap)

end


local do_make_mapping_func(mode, noremap)
    return function(lhs, rhs, silent) 
        if (string.startswith(lhs, '<silent>'))
        
        do_mapping(mode, lhs, rhs, noremap, silent)
    end
end


return KeyMap


