local String = require 'lib.lua.core.string'
local Table  = require 'lib.lua.core.table'


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


-- for internal use (allows us to define functions in any order w/in the file)
local Mapper = {}

local KeyMapper = {}
KeyMapper.__index = KeyMapper


function KeyMapper.new(default_options)
    local this = { options = default_options }
    setmetatable(this, KeyMapper)
    return this
end


-- core mapping logic ----------------------------------------------------------

-- more or less sourced from https://github.com/brainfucksec/neovim-lua/blob/main/nvim.lua.keymaps.lua
function Mapper.do_mapping(mode, lhs, rhs, options)
    if (type(rhs) == 'string') then
        vim.api.nvim_set_keymap(mode, lhs, rhs, options)
    elseif (type(rhs) == 'function') then
        vim.keymap.set(mode, lhs, rhs, options)
    else
        error('(lhs) ' .. tostring(lhs) .. ' = (rhs) ' .. tostring(rhs) .. ': rhs is of an unrecognized type (' .. type(rhs) .. ')')
    end
end

-- mapping function construction -----------------------------------------------

function Mapper.do_make_mapping_func(mode, noremap)
    return function(lhs, rhs, opts)
        local silent = String.startswith(lhs, '<silent>')
        lhs = lhs:gsub('<silent>', '')

        opts = opts or {}
        local silent_and_noreamp = { noremap = noremap, silent = silent }
        local options = Table.combine(opts, silent_and_noreamp)

        return Mapper.do_mapping(mode, lhs, rhs, options)
    end
end


function Mapper.make_mapping_func(func_name)
    if (func_name == MAP or func_name == NOREMAP) then
        return Mapper.do_make_mapping_func(Mode.none, func_name == NOREMAP)
    end

    local mode, noremap = Mapper.parse_func_name(func_name)
    return Mapper.do_make_mapping_func(mode, noremap)
end


-- TODO: create "Indexable" class that implements python-like indexing for strings
--       see `lib.lua.core.string.Indexable`
function Mapper.is_noremap(func_name)
    return String.startswith(func_name, NOREMAP) or
           String.startswith(func_name:sub(2, #func_name),  NOREMAP)
end


function Mapper.parse_func_name(func_name)
    return func_name:sub(1, 1), Mapper.is_noremap(func_name)
end

-- function name validation ----------------------------------------------------

function Mapper.is_no_mode_form(func_name)
    return func_name == MAP or func_name == NOREMAP
end


function Mapper.is_func_name_format_valid(func_name)
    -- function name can't be valid if it's not present, or if it's len < 3
    if (func_name == nil or #func_name < 3) then
        return false
    end

    -- valid if it's either "map" or "noremap"
    if (Mapper.is_no_mode_form(func_name)) then
        return true
    end

    local mode = func_name:sub(1, 1)

    -- invalid if its first letter isn't one of the known modes
    if (Mode[mode] == nil) then
        return false
    end

    local mp_form = mode .. MAP
    local nrmp_form = mode .. NOREMAP

    -- valid if it equals its mode + "map" or "noremap"
    return func_name == mp_form or func_name == nrmp_form
end


function KeyMapper:__index(func_name)
    if (not Mapper.is_func_name_format_valid(func_name)) then
        error('unrecognized key mapping function=' .. func_name)
    end

    return Mapper.make_mapping_func(func_name)
end

return KeyMapper.new()

