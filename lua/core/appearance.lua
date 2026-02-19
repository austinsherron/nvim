-- colorscheme -----------------------------------------------------------------

vim.cmd.colorscheme 'material-darker'

-- vim interface customizations  -----------------------------------------------

Safe.require('utils.api.vim.interface').init()

GetLogger('INIT'):info 'Appearance initialized'
