---- globals -------------------------------------------------------------------

require 'utils.globals' -- import globals before doing anything else

---- bootstrap -----------------------------------------------------------------

Safe.require 'core.bootstrap' -- "bootstrap" settings must come first

---- commands, pre -------------------------------------------------------------

Safe.require 'core.cmd.auto.before' -- some cmds should load before plugins

---- plugins -------------------------------------------------------------------

-- load plugins as early as reasonably possible
Safe.require 'plugins'

---- commands, post ------------------------------------------------------------

Safe.require 'core.cmd.auto.after' -- some cmds may depend on plugins, so load after
Safe.require 'core.cmd.user'

---- config --------------------------------------------------------------------

Safe.require 'keymap' -- keymap
Safe.require 'core.settings' -- core settings
Safe.require 'core.appearance' -- colorscheme

GetLogger('INIT'):info 'Neovim initialization complete'

