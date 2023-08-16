require 'utils.globals'                -- import globals before doing anything else

---------- bootstrap ----------

Safe.require 'core.bootstrap'          -- "bootstrap" settings must come first

-------- commands, pre --------

Safe.require 'core.cmd.auto.before'    -- some cmds should load before plugins

----------- plugins -----------

-- plugins
Safe.require(
  'utils.plugins.pluginmanager',       -- load plugins as early as reasonably possible
  function(m) m.init('plugins') end
)

------- commands, post --------

-- commands, post-plugin
Safe.require 'core.cmd.auto.after'     -- some cmds may depend on plugins, so load after
Safe.require 'core.cmd.user'

----------- config ------------

-- remaining configuration:
Safe.require 'keymap'                  -- keymap
Safe.require 'core.settings'           -- core settings
Safe.require 'core.appearance'         -- colorscheme

