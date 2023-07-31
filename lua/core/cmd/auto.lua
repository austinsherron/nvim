local Autocmd = require 'utils.core.autocmd'


-- so lines inserted from comments don't cause comments continuation
Autocmd.new()
  :withEvents({ 'BufNewFile', 'BufRead' })
  :withOpt('command', 'setlocal formatoptions-=cro')
  :create()

