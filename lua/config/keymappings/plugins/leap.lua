local km = require 'nvim.lua.utils.mapper'


-- TODO: refactor KeyMapper so that it can be instantiated w/ the state present in this
--       function
local function options(desc)
    return { desc = 'leap: ' .. desc, nowait = true }
end


-- interactions ----------------------------------------------------------------

-- TODO: figure out better mapping for these
-- km.nnoremap("'", '<Plug>(leap-forward-till)',  options('forward'))
-- km.nnoremap('"', '<Plug>(leap-backward-till)', options('backward'))
