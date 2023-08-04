local KM = require 'lua.utils.core.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function make_options(plugin)
  return function(desc)
    return { desc = plugin .. ': ' .. desc, nowait = true }
  end
end

local options

-- aerial ----------------------------------------------------------------------

options = make_options('aerial')

KM.nnoremap('<leader>a', ':AerialToggle<CR>',    options('toggle sidebar'))
KM.nnoremap('<leader>A', ':AerialNavToggle<CR>', options('toggle popup'))

-- mason -----------------------------------------------------------------------

options = make_options('mason')

KM.nnoremap('<leader>M', ':Mason<CR>', options('open lsp mgr.'))

-- sniprun ---------------------------------------------------------------------

options = make_options('sniprun')

KM.vnoremap('<leader>R', ':SnipRun<CR>', options('run'))

-- treesj ---------------------------------------------------------------------

options = make_options('TreeSJ')

KM.nnoremap('<leader>m', ':TSJToggle<CR>', options('toggle split/join block'))


