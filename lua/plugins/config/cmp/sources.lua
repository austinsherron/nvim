
-- buffer ----------------------------------------------------------------------

local function get_all_bufs()
  return vim.api.nvim_list_bufs()
end

local Src = {}

function Src.buffer()
  return {
    name = 'buffer',
    option = {
      keyword_length = 2,
      get_bufnrs = get_all_bufs,
    }
  }
end

-- calc ------------------------------------------------------------------------

function Src.calc()
  return {
    name = 'calc',
  }
end

-- emoji -----------------------------------------------------------------------

function Src.emoji()
  return {
    name = 'emoji',
  }
end

-- git -------------------------------------------------------------------------

function Src.git()
  return {
    name = 'git',
  }
end

-- lsp -------------------------------------------------------------------------

function Src.lsp()
  return {
    name = 'nvim_lsp',
  }
end

-- luasnip ---------------------------------------------------------------------

function Src.luasnip()
  return {
    name = 'luasnip',
  }
end

-- path ------------------------------------------------------------------------

function Src.path()
  return {
    name = 'path',
  }
end

-- spell -----------------------------------------------------------------------

function Src.spell()
  return {
    name = 'spell',
  }
end

-- treesitter ------------------------------------------------------------------

function Src.treesitter()
  return {
    name = 'treesitter',
  }
end

-- all -------------------------------------------------------------------------

function Src.all()
  return {
    Src.buffer(),
    Src.calc(),
    Src.emoji(),
    Src.git(),
    Src.lsp(),
    Src.luasnip(),
    Src.path(),
    Src.spell(),
    Src.treesitter(),
  }
end

return Src

