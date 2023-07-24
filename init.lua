local safe = require 'utils.errorhandling.safe'


-- init ------------------------------------------------------------------------

-- "bootstrap" settings must come first
safe.require 'core.bootstrap'

-- plugins ---------------------------------------------------------------------

-- note: settings/keymap has dependencies on plugins, so load them first
safe.require(
  'utils.plugins.pluginmanager',
  function(m) m.init('plugins') end
)

-- keymap ---------------------------------------------------------------------

safe.require 'keymap'

-- settings -------------------------------------------------------------------

safe.require 'core.settings'

-- appearance ------------------------------------------------------------------

safe.require 'core.appearance'

