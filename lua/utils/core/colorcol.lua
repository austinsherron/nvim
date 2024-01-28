local Buffer = require 'utils.api.vim.buffer'
local Interface = require 'utils.api.vim.interface'

local Colors = Interface.Colors
local Highlight = Interface.Highlight
local OptionKey = Buffer.OptionKey

local CONFIG = {
  lua = { len = 90, style = { color = Colors.SRCERY_CYAN } },
}

--- Utility for configuring color column
---
---@class ColorColumn
local ColorColumn = {}

local function set_colcolor(config)
  local style = config.style
  local hl = Highlight.new 'ColorColumn'

  if style.hl ~= nil then
    hl = style.hl
  elseif String.not_nil_or_empty(style.link) then
    hl:link(style.link)
  elseif String.not_nil_or_empty(style.color) then
    hl:foreground(style.color):background(style.color)
  else
    Err.raise 'ColorColumn: Unrecognized colorcolumn style definition'
  end

  Interface.set_highlight(hl)
end

local function enable_colorcol(config)
  vim.cmd(fmt('setlocal colorcolumn=%s', config.len))
end

--- Enables the color column for the provided buffer.
---
---@param bufnr integer: the buffer for which to enabled to color column
function ColorColumn.forbuf(bufnr)
  local filetype = Buffer.getoption(bufnr, OptionKey.FILETYPE)
  local config = CONFIG[filetype]

  if config == nil then
    return
  end

  set_colcolor(config)
  enable_colorcol(config)
end

--- Disables the color column.
function ColorColumn.disable()
  vim.cmd 'set colorcolumn='
end

return ColorColumn
