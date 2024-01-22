local Buffer = require 'utils.api.vim.buffer'
local Interface = require 'utils.api.vim.interface'

local Colors = Interface.Colors
local Highlight = Interface.Highlight
local OptionKey = Buffer.OptionKey

local CONFIG = {
  lua = { len = 90, color = Colors.CYAN },
}

--- Utility for configuring color column
---
---@class ColorColumn
local ColorColumn = {}

local function set_colcolor(config)
  Interface.set_highlight(
    Highlight.new('ColorColumn'):foreground(config.color):background(config.color)
  )
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
