local o = vim.o
local opt = vim.opt

---- interaction settings ------------------------------------------------------

o.mouse = nil

---- general settings ----------------------------------------------------------

o.nu          = true             -- line numbers 
o.syntax      = 'on'
o.ruler       = true

-- allows nvim to copy/paste to/from system clipboards
opt.clipboard:append('unnamedplus')

---- indent settings -----------------------------------------------------------

o.ai           = true            -- auto indent
o.si 	       = true            -- smart indent
o.smartlindent = true            -- must set both this and above
o.expandtab    = true
o.shiftwidth   = 4
o.softtabstop  = o.shiftwidth

---- search settings -----------------------------------------------------------

o.incsearch  = true
o.hlseach    = true
o.ignorecase = true
o.smartcase  = true

---- display settings ----------------------------------------------------------

o.showbreak = "↪ "
o.scrolloff = 7
o.termguicolors = true

---- functional settings -------------------------------------------------------

-- hide, don't dump, buffers when switching
o.hidden = true                  
-- show diffs in vertical splits by default
opt.diffopt:append { "vertical" }
-- save to swp after 1s of not typing
o.updatetime = 1000
-- preview menu options for autocompletion
opt.completeopt = { "menuone", "noselect" }
-- how many lines must change to report on # of lines changed (so, always)
o.report = 0
