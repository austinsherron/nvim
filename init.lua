---- globals -------------------------------------------------------------------

require 'utils.globals' -- import globals before doing anything else

---- diagnostics ---------------------------------------------------------------

require('core.exit_trace').setup() -- must wrap vim.call before plugins load

---- bootstrap -----------------------------------------------------------------

Safe.require 'core.bootstrap' -- "bootstrap" settings must come first

---- plugins -------------------------------------------------------------------

Safe.require 'plugins' -- load plugins as early as reasonably possible

---- commands ------------------------------------------------------------------

Safe.require 'core.cmd.auto'
Safe.require 'core.cmd.user'

---- config --------------------------------------------------------------------

Safe.require 'keymap'
Safe.require 'core.settings'
Safe.require 'core.filetypes'
Safe.require 'core.appearance' -- colorscheme, etc.
Safe.require 'lsp' -- language servers, debugger config,, etc.

GetLogger('INIT'):info 'Neovim initialization complete'
