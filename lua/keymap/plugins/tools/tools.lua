local KM = require 'lua.utils.core.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function make_options(plugin)
  return function(desc)
      return { desc = plugin .. ': ' .. desc, nowait = true }
  end
end

local options

-- link visitor ----------------------------------------------------------------

options =  make_options('link-visitor')

KM.nnoremap('<leader>ol', ':VisitLinkUnderCursor<CR>', options('open link under cursor'))
KM.nnoremap('<leader>oc', ':VisitLinkNearest<CR>',     options('open link nearest cursor'))
KM.nnoremap('<leader>oo', ':VisitLinkInBuffer<CR>',    options('choose link from buffer'))

-- neogen ----------------------------------------------------------------------

options =  make_options('neogen')

KM.nnoremap('<leader>Df', ':Neogen func<CR>',  options('function docstring'))
KM.nnoremap('<leader>Dc', ':Neogen class<CR>', options('class docstring'))

