local KeyMapper = require 'utils.core.mapper'
local View = require 'utils.api.vim.view'

local KM = KeyMapper.new({ nowait = true })

-- filetype close --------------------------------------------------------------

local function close_help()
  View.close({ filetype = 'help' })
end

KM:bind_one('<leader>hq', close_help, { desc = 'close: help windows' })
