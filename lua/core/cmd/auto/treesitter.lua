-- treesitter ------------------------------------------------------------------

--[[
  enables neovim's built-in treesitter highlighting and indentation for buffers
  that have a parser available
--]]

local Autocmd = require 'utils.core.autocmd'

local LOGGER = GetLogger 'AUTOCMD'

LOGGER:info 'Creating treesitter autocmds'

-- INFO: this autocmd is taken from the quickstart section of nvim-treesitter's help docs
Autocmd.new()
  :withDesc('Enable treesitter highlight and indent')
  :withEvent('FileType')
  :withPattern('*')
  :withCallback(function()
    -- syntax highlighting, provided by neovim
    vim.treesitter.start()

    -- NOTE: uncomment to activate treesitter folds and indentation
    -- -- folds, provided by neovim
    -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- vim.wo.foldmethod = 'expr'
    -- -- indentation, provided by nvim-treesitter
    -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end)
  :create()
