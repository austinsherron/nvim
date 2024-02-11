---- globals -------------------------------------------------------------------

require 'utils.globals' -- import globals before doing anything else

---- init ----------------------------------------------------------------------

require 'utils.plugins.initialize' -- for a fresh install

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
Safe.require 'core.appearance' -- colorscheme, etc.
Safe.require 'lsp' -- language servers, debugger config,, etc.

GetLogger('INIT'):info 'Neovim initialization complete'
