-- git -------------------------------------------------------------------------

--[[
  contains autocommands related to git
--]]

local Autocmd = require 'utils.core.autocmd'
local Buffer = require 'utils.api.vim.buffer'
local Git = require 'utils.api.git'
local Path = require 'toolbox.system.path'
local Window = require 'utils.api.vim.window'

local LOGGER = GetLogger 'AUTOCMD'

LOGGER:info 'Creating git autocmds'

---@note: unanchored so branches w/ a leading segment (i.e.:
--- "austin/plat-2240-cache-warming") match on the ticket id, not the segment
local TICKET_PATTERN = '(%a+%-%d+)'

--- Prefixes an empty commit message w/ the ticket id in the active branch's name, if the
--- branch name contains one.
---
---@param ev AutoCommandCallbackParams: params of the event that triggered this callback
local function prefix_commit_msg(ev)
  local subject = Buffer.getlines(ev.buf, 0, 1)[1]

  ---@note: a non-empty subject means git pre-populated the message (i.e.: an amend, a
  --- reword during a rebase, a merge), so there's nothing to prefix
  if not String.nil_or_empty(subject) then
    return
  end

  ---@note: the buffer's dir (i.e.: the git dir) locates the repo, not the cwd, which can
  --- be a different worktree than the one being committed to
  local branch = Git.branch_name(Path.dirname(Buffer.getname(ev.buf)))
  local ticket = branch:match(TICKET_PATTERN)

  if ticket == nil then
    LOGGER:debug('No ticket id in branch=%s', { branch })
    return
  end

  local prefix = String.upper(ticket) .. ': '
  Buffer.setlines(ev.buf, 0, 1, { prefix })

  if Window.tobuf() == ev.buf then
    Window.set_cursor(1, #prefix)
  end
end

Autocmd.new()
  :withDesc('Prefixes commit messages w/ the ticket id in the branch name')
  :withEvent('FileType')
  :withPattern('gitcommit')
  :withCallback(prefix_commit_msg)
  :create()
