-- appearance ------------------------------------------------------------------

--[[
  contains autocommands related to the chezmoi plugin
--]]

local Autocmd = require 'utils.core.autocmd'
local Buffer = require 'utils.api.vim.buffer'
local Path = require 'toolbox.system.path'

local LOGGER = GetLogger 'AUTOCMD'
local TMPL_EXT = '.tmpl'
local TMPL_FT = 'template'

LOGGER:info 'Creating chezmoi autocmds'

local function is_tmpl(buf)
  return String.endswith(buf.filename, TMPL_EXT) and buf.filetype == TMPL_FT
end

local function make_filename(buf)
  local name = Path.trim_extension(buf.filename)

  if Path.extension(name) == nil then
    name = name .. '.sh'
  end

  return name
end

local function override_filetype(ev)
  local buf = Buffer.info(ev.buf)

  if buf.filename == nil or not is_tmpl(buf) then
    LOGGER:debug('buffer=%s is not a template', { buf.id })
    return
  end

  local name = make_filename(buf)
  local ft = buf.filetype
  local newft = vim.filetype.match({ buf = buf.id, filename = name })

  LOGGER:debug('buffer=%s should have ft=%s w/ filename=%s', { buf.id, newft, name })

  if newft ~= nil and ft ~= newft then
    LOGGER:debug('updating filetype for buffer=%s from %s -> %s', { name, ft, newft })
    vim.cmd('setlocal filetype=' .. newft)
  end
end

-- NOTE: this is an (somewhat flaky) attempt to fill in gaps in chezmoi.vim
Autocmd.new()
  :withDesc('Manually sets the filetype of the buffer, if necessary')
  :withEvents({ 'BufAdd', 'BufEnter' })
  :withCallback(override_filetype)
  :create()
