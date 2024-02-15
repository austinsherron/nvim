std = 'luajit'
max_line_length = 90
read_globals = {
  -- external globals
  'vim',
}
globals = {
  ---- external globals
  -- vim
  'vim.g',
  'vim.o',
  'vim.opt',
  -- hammerspoon
  'hs',
  '_',
  ---- internal global config entity
  'NvimConfig',
  ---- internal global logging utils
  'GetLogger',
  'GetNotify',
  ---- internal global classes
  'Array',
  'Bool',
  'Dict',
  'Stream',
  'String',
  'Table',
  'Err',
  'Set',
  'Lazy',
  'Map',
  'OnErr',
  'Safe',
  ---- internal global functions
  'filter',
  'fmt',
  'foreach',
  'map',
  'ternary',
}
