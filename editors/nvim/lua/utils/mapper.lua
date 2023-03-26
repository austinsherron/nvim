require 'lib.lua.string'


local Mode = {
    none = '',
    n = 'n',
    i = 'i',
    l = 'l',
    o = 'o',
    t = 't',
    c = 'c',
    x = 'x',
    s = 's',
    v = 'v',
}

local NOREMAP = 'noremap'
local MAP = 'map'


-- TODO: probably would be good to add validation logic, though if this just ends up being an 
--       internally used util, it's probalby fine...


local KeyMapper = {}
KeyMapper.__index = {}


local function KeyMapper_new()
    local this = {}
    setmetatable(this, KeyMapper)
    return this
end


-- more or less sourced from https://github.com/brainfucksec/neovim-lua/blob/main/nvim/lua/core/keymaps.lua
local function do_mapping(mode, lhs, rhs, noremap, silent)
    local noremap = noremap and true
    local silent = silent and true

    local options = { noremap = true, silent = true }

    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


-- TODO: create "Indexable" class that implements python-like indexing for strings
--       see `lib.lua.string.Indexable`
local function is_noremap(func_name)
    return string.startswith(func_name, NOREMAP) or 
           string.startswith(func_name:sub(2, #func_name),  NOREMAP)
end


local function do_make_mapping_func(mode, noremap)
    return function(lhs, rhs, silent) 
        local silent = string.startswith(lhs, '<silent>')
        return do_mapping(mode, lhs, rhs, noremap, silent)
    end
end


local function parse_func_name(func_name)
    return func_name:sub(1, 1), is_noremap(func_name)
end


local function make_mapping_func(func_name)
    if (func_name == MAP or func_name == NOREMAP) then
        return do_make_mapping_func(Mode.none, func_name == NOREMAP)
    end

    mode, noremap = parse_func_name(func_name)
    return do_make_mapping_func(mode, noremap)
end


local function is_no_mode_form(func_name)
    return func_name == MAP or func_name == NOREMAP
end


local function is_func_name_format_valid(func_name)
    if (func_name == nil or #func_name < 3) then
        return false
    end

    if (is_no_mode_form(func_name)) then
        return true
    end

    local mode = func_name:sub(1, 1)

    if (Mode[mode] == nil) then
        return false
    end

    local mp_form = mode .. MAP
    local nrmp_form = mode .. NOREMAP

    return func_name == mp_form or func_name == nrmp_form
end


function KeyMapper:__index(func_name)
    if (not is_func_name_format_valid(func_name)) then
        error('unrecognized mapping function=' .. func_name)
    end
        
    return make_mapping_func(func_name)
end


return KeyMapper_new()

