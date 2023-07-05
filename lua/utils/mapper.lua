local str = require 'lib.lua.core.string'
local tbl = require 'lib.lua.core.table'


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
--       internally used util, it's probably fine...


local KeyMapper = {}
KeyMapper.__index = {}


local function KeyMapper_new(defualt_options)
    local this = { options = defualt_options }
    setmetatable(this, KeyMapper)
    return this
end


-- more or less sourced from https://github.com/brainfucksec/neovim-lua/blob/main/nvim/lua/core/keymaps.lua
local function do_mapping(mode, lhs, rhs, options)
    if (type(rhs) == 'string') then
        vim.api.nvim_set_keymap(mode, lhs, rhs, options)
    elseif (type(rhs) == 'function') then
        vim.keymap.set(mode, lhs, rhs, options)
    else
        error('(lhs) ' .. tostring(lhs) .. ' = (rhs) ' .. tostring(rhs) .. ' is of an unrecognized type ' .. type(rhs))
    end
end


-- TODO: create "Indexable" class that implements python-like indexing for strings
--       see `lib.lua.core.string.Indexable`
local function is_noremap(func_name)
    return str.startswith(func_name, NOREMAP) or
           str.startswith(func_name:sub(2, #func_name),  NOREMAP)
end


local function do_make_mapping_func(mode, noremap)
    return function(lhs, rhs, opts)
        local silent = str.startswith(lhs, '<silent>')
        local lhs = lhs:gsub('<silent>', '')

        local opts = opts or {}
        local silent_and_noreamp = { noremap = noremap, silent = silent }
        local options = tbl.combine(opts, silent_and_noreamp)

        return do_mapping(mode, lhs, rhs, options)
    end
end


local function parse_func_name(func_name)
    return func_name:sub(1, 1), is_noremap(func_name)
end


local function make_mapping_func(func_name)
    if (func_name == MAP or func_name == NOREMAP) then
        return do_make_mapping_func(Mode.none, func_name == NOREMAP)
    end

    local mode, noremap = parse_func_name(func_name)
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

