std = 'luajit'
max_line_length = 90
read_globals = {
  -- external globals
  'vim',
}
globals = {
  -- external globals
  'vim.g',
  'vim.o',
  'vim.opt',
  '_',
  -- internal global logging utils
  'GetLogger',
  'Notify',
  -- internal global classes
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
  -- internal global functions
  'filter',
  'fmt',
  'foreach',
  'map',
  'ternary',
}
