-- colorscheme -----------------------------------------------------------------

vim.cmd.colorscheme 'srcery'

-- vim interface customizations  -----------------------------------------------

Safe.require('utils.api.vim.interface').init()

GetLogger('INIT'):info 'Appearance initialized'
