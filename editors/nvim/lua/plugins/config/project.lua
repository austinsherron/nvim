local env = require('lib.lua.env')


local function get_exclude_patterns()
  local editors_root = env.editors_root()
  local system_root = env.config_root() .. '/system'
  local tooling_root = env.tooling_root()

  return {
    '!' .. editors_root .. '/vim/.vim',
    '!' .. editors_root .. '/vim/archive',
    '!' .. editors_root .. '/nvim/packages',
    '!' .. system_root  .. '/terminal/hyper_plugins',
    '!' .. tooling_root .. '/tmux/plugins',
    '!' .. tooling_root .. '/xplr/packages',
  }
end


local function get_include_pattern()
    return '>' .. env.sigma_root() 
end


local function get_patterns()
  local patterns = get_exclude_patterns()
  table.insert(patterns, get_include_pattern())

  return patterns
end


function project_opts()
  return {
    -- patterns = get_patterns(),
  }
end

