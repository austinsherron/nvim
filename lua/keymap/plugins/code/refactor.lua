local KeyMapper = require 'utils.core.mapper'
local Refactor = require 'utils.api.refactor'

local KM = KeyMapper.new({ desc_prefix = 'refactor: ', nowait = true })

-- interactions ----------------------------------------------------------------

local function extractfn_tofile()
  Refactor.extractfn(true)
end

local function extractblock_tofile()
  Refactor.extractblock(true)
end

KM:bind({
  { "'ef", Refactor.extractfn, { desc = 'extract function' }, { 'v' } },
  { "'eF", extractfn_tofile, { desc = 'extract function to file' }, { 'v' } },
  { "'if", Refactor.inlinefn, { desc = 'inline function' } },
  { "'ev", Refactor.extractvar, { desc = 'extract variable' }, { 'v' } },
  { "'iv", Refactor.inlinevar, { desc = 'inline variable' }, { 'n', 'v' } },
  { "'eb", Refactor.extractblock, { desc = 'extract block' } },
  { "'eB", extractblock_tofile, { desc = 'extract block to file' } },
}):done()
