local function init()
    local pathbase = vim.fn.stdpath('data') 
    local relpath = 'lua/plugins/lazy/lazy.nvim'

    local lazypath = pathbase .. relpath

    if not vim.loop.fs_stat(lazypath) then
      vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
      })
    end
    vim.opt.rtp:prepend(lazypath)
end


return {
    init = init
}
