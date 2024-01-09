-- colorscheme -----------------------------------------------------------------

vim.cmd.colorscheme 'nightfox'

-- vim interface customizations  -----------------------------------------------

Safe.require('utils.api.vim.interface').init()

GetLogger('INIT'):info 'Appearance initialized'
