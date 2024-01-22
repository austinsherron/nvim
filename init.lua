---- globals -------------------------------------------------------------------

require 'utils.globals' -- import globals before doing anything else

---- bootstrap -----------------------------------------------------------------

Safe.require 'core.bootstrap' -- "bootstrap" settings must come first

---- plugins -------------------------------------------------------------------

-- load plugins as early as reasonably possible
Safe.require 'plugins'

---- commands ------------------------------------------------------------------

Safe.require 'core.cmd.auto'
Safe.require 'core.cmd.user'

---- config --------------------------------------------------------------------

Safe.require 'keymap' -- keymap
Safe.require 'core.settings' -- core settings
Safe.require 'core.appearance' -- colorscheme
Safe.require 'lsp' -- language servers, etc.

GetLogger('INIT'):info 'Neovim initialization complete'
