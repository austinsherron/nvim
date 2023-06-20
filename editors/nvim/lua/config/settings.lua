require 'lib.lua.run'


local o = vim.o
local opt = vim.opt


---- interaction settings ------------------------------------------------------

o.mouse = nil

---- general settings ----------------------------------------------------------

o.syntax        = 'on'
o.ruler         = true
o.formatoptions = 'tcrqn2lj'
o.inccommand    = 'nosplit'        -- incremental live completion

-- allows nvim to copy/paste to/from system clipboards
opt.clipboard:append({'unnamedplus'})

---- spellcheck setting --------------------------------------------------------

o.spell = true
o.spelllang = 'en_us'
o.spellsuggest = 20
o.spellfile = vim.fn.stdpath('config') .. '/.spell/en.utf-8.add'

---- indent settings -----------------------------------------------------------

o.ai           = true            -- keep indentation from previous line
o.autoindent   = true            -- need to set this and above?
o.si           = true            -- smart indent
o.smartlindent = true            -- must set both this and above

-- tabs as spaces; default tab size = 4
o.expandtab    = true
o.shiftwidth   = 4
o.softtabstop  = o.shiftwidth
o.tabstop      = o.shiftwidth

---- search settings -----------------------------------------------------------

o.incsearch  = true
o.hlseach    = true
o.ignorecase = true
o.smartcase  = true

---- display settings ----------------------------------------------------------

o.showbreak     = '↪ '           -- show at line break
o.scrolloff     = 7              -- min 7 lines around cursor
o.termguicolors = true           -- enable truecolor
o.nu            = true           -- line numbers
o.signcolumn    = 'yes'          -- display the sign column
o.cursorline    = true           -- show the cursor line
o.linebreak     = true           -- visually break lines at max width

-- show tab characters, line-endings (enable list for this)
o.list        = true
opt.listchars = { ['tab'] = '>.', ['trail'] = '.' , ['nbsp'] = '‸' }

---- functional settings -------------------------------------------------------

o.hidden        = true                              -- hide, don't dump, buffers when switching
opt.completeopt = { 'menuone', 'noselect' }         -- preview menu options for autocompletion
o.report        = 0                                 -- min lines changed to report # lines changed

-- show diffs in vertical splits by default
opt.diffopt:append({'vertical'})

-- recovery files
o.undofile = true                                   -- enable undo history
o.swapfile = false                                  -- disable swap files

-- ignore certain files when opening buffers from inside neovim
vim.opt.wildignore:append({ '*.o', '*.obj', '**/.git/*', '*.swp', '*.pyc', '*.class', '**/node_modules/*', '*.bak' })

-- prefer splitting windows below or to the right
vim.o.splitbelow = true
vim.o.splitright = true

-- unknown/disabled settings ---------------------------------------------------

-- vim.opt.path:append { '**' }             -- add directories upwards as search path
-- o.updatetime = 1000                      -- save to swp after 1s of not typing (why set if swap = false?)

