local Hydra     = require 'plugins.extensions.hydra'
local KeyMapper = require 'utils.core.mapper'

local HintFmttr = Hydra.HintFormatter

local trouble = require 'trouble'


local function open(mode)
  return function() trouble.open(mode) end
end


local function close()
  return function() trouble.close() end
end


local function refresh()
  return function() trouble.refresh() end
end

local KM = KeyMapper.new({
  desc_prefix = 'trouble: ',
})

-- interactions ----------------------------------------------------------------

KM:bind_one('<leader>tr', open(), { desc = 'open default mode' })

KM:with_hydra({ name = '🚦 Trouble', body = '<leader>T' })
  :with({ hint = HintFmttr.bottom_2(), color = 'blue' })
  :bind({
    { 'o',       open(),                        { desc = 'open default mode'               }},
    { 'w',       open('workspace_diagnostics'), { desc = 'open workspace diagnostics mode' }},
    { 'd',       open('document_diagnostics'),  { desc = 'open document diagnostics mode'  }},
    { 't',       open('todo'),                  { desc = 'open todo comments mode'         }},
    { 'q',       open('quickfix'),              { desc = 'open quickfix mode'              }},
    { 'l',       open('loclist'),               { desc = 'open loclist mode'               }},
    { 'r',       refresh(),                     { desc = 'refresh'                         }},
    { 'x',       close(),                       { desc = 'close'                           }},
    { '<Enter>', open(),                        { desc = 'open default mode'               }},
  }):done({ purge = 'current' })

