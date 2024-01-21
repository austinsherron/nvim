local Interaction = require 'utils.api.vim.interaction'

local LOGGER = GetLogger 'LSP'

--- Parameterizes lsp formatting.
---
---@class LspFormatOpts
---@field name string|nil: optional, defaults to all attached clients; specifies the lsp
--- server to use to format
---@field async boolean|nil: optional, defaults to false; if true, formatting will run
--- asynchronously
---@field bufnr integer|nil: optional, defaults to current buffer; the buffer to format

--- Api wrapper for lsp related vim functionality.
---
---@class Lsp
local Lsp = {}

--- Opens a popup w/ info about lsp clients, if any, attached to the current buffer.
function Lsp.info()
  vim.api.nvim_command 'LspInfo'
end

--- Checks if the provided lsp server is active in buffer w/ id == bufnr.
---
---@param server string: the name of the lsp server to check
---@param bufnr integer: the id of the buffer to check
---@return boolean: true if the provided lsp server is active in buffer w/ id == bufnr,
--- false otherwise
function Lsp.isactive(server, bufnr)
  local lsp = vim.lsp.get_active_clients({
    name = server,
    bufnr = bufnr,
  })

  local isactive = Table.not_nil_or_empty(lsp)
  local is_or_not = ternary(isactive, '', 'not')

  LOGGER:trace('Server=%s is%s active in buffer=%s', { server, is_or_not, bufnr })
  return isactive
end

local function lspsaga_cmd(cmd, ...)
  local args = String.join(Table.pack(...), ' ')
  local sep = ternary(String.nil_or_empty(args), '', ' ')

  return fmt('Lspsaga %s%s%s', cmd, sep, args)
end

local function run_lspsaga(cmd, ...)
  local fullcmd = lspsaga_cmd(cmd, ...)
  Safe.call(vim.api.nvim_command, { prefix = 'Running Lspsaga cmd' }, fullcmd)
end

--- Jumps to the previous diagnostic.
function Lsp.prev_diagnostic()
  run_lspsaga 'diagnostic_jump_prev'
end

--- Jumps to the next diagnostic.
function Lsp.next_diagnostic()
  run_lspsaga 'diagnostic_jump_next'
end

--- Opens a hover w/ documentation for the item under the cursor, if any.
function Lsp.hover_doc()
  run_lspsaga 'hover_doc'
end

--- Opens a floating window w/ and the definition site of the item under the cursor.
function Lsp.peek_definition()
  run_lspsaga 'peek_definition'
end

--- Opens a floating window w/ and the type definition site of the item under the cursor.
function Lsp.peek_type_definition()
  run_lspsaga 'peek_type_definition'
end

--- Navigates to the definition site of the item under the cursor.
function Lsp.goto_definition()
  run_lspsaga 'goto_definition'
end

--- Navigates to the type definition site of the item under the cursor.
function Lsp.goto_type_definition()
  run_lspsaga 'goto_type_definition'
end

--- Opens a floating window that shows information on incoming calls to the item under the
---cursor.
function Lsp.incoming_calls()
  run_lspsaga 'incoming_calls'
end

--- Opens a floating window that shows information on outgoing calls from the item under
-- the cursor.
function Lsp.outgoing_calls()
  run_lspsaga 'outgoing_calls'
end

--- Opens a floating window that shows information on references to the item under the
--- cursor.
function Lsp.finder()
  run_lspsaga 'finder'
end

--- Opens the code action menu if any code actions are available at the cursor's location.
function Lsp.code_action()
  run_lspsaga 'code_action'
end

--- Formats the current buffer according to opts.
---
---@param opts LspFormatOpts|nil: optional; name specifies the lsp
--- server to use to format; async == true will cause formatting to run asynchronously
function Lsp.format(opts)
  opts = opts or {}

  LOGGER:debug('Running lsp formatting w/ opts=%s', { opts })
  Safe.call(vim.lsp.buf.format, { prefix = 'LSP' }, opts)
end

local function get_replace_arg(prompt)
  local arg, cancelled = Interaction.input(prompt, { required = true })
  return ternary(not cancelled, arg)
end

--- Implements rename functionality for the item under the cursor. When called, this
--- function opens an input dialog prompting for a new name. Exiting w/o providing a new
--- name cancels the operation.
function Lsp.rename()
  run_lspsaga 'rename'
end

--- Implements project wide replace. When called, this function spawns two required input
--- dialogs: one for the text to replace, and one for the text w/ which to replace. If
--- either input is canceled, the function exits w/o performing any action.
function Lsp.replace()
  local to_replace = get_replace_arg 'Replace in project'
  if to_replace == nil then
    return
  end

  local replace_with = get_replace_arg 'With'
  if replace_with == nil then
    return
  end

  run_lspsaga('project_replace', to_replace, replace_with)
end

--- Adds a directory to the workspace. When called, this function opens and input
--- prompting for the directory to add. Exiting w/o providing a dirpath cancels the
--- operation.
function Lsp.add_workspace_folder()
  vim.lsp.buf.add_workspace_folder()
end

--- Removes a directory to the workspace. When called, this function opens and input
--- prompting for the directory to remove. Exiting w/o providing a dirpath cancels the
--- operation.
function Lsp.remove_workspace_folder()
  vim.lsp.buf.remove_workspace_folder()
end

--- Gets the current workspace folders. If inspect == true, the folders will be displayed
--- in a user-facing notification.
---
---@param inspect boolean|nil: optional, defaults to false; if true, the folders will be
--- displayed in a user-facing notification
---@return string[]: an array of workspace folder paths
function Lsp.get_workspace_folders(inspect)
  local wkspace_folders = vim.lsp.buf.list_workspace_folders()

  if inspect ~= true then
    return wkspace_folders
  end

  -- TODO: make this a bit more user friendly/prettier
  local folderstr = '* ' .. String.join(wkspace_folders, '\n* ')
  Notify.info(folderstr)

  return wkspace_folders
end

return Lsp
