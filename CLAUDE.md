# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Code Style Requirements

- ALWAYS Do the right thing. Always code the optimal solution. Think changes through step by step. If something is blocking you from implementing an agreed upon solution, ask the user for confirmation about the change.
- ALWAYS use type hints! All function definition parameters and return values need type hints. All generic types need a generic type. Be sparing with `any` - always try and find an appropriate type to use before resorting to it.
- NEVER use inline imports. All imports must be placed at the top of the file. If an inline is used to avoid a circular dependecy, ask the user directly how to resolve the issue.
- RARELY (almost NEVER) directly call raw/external APIs (i.e.: `vim.*`, or APIs imported from plugins) outside of wrappers. Instead, use existing API utilities (in `utils.api`) or create a new API utility that wraps external API.

## Overview

Personal Neovim configuration in Lua. Uses **lazy.nvim** (installed to `./packages/lazy.nvim`) for plugin management.

## Commands

```bash
luacheck lua/              # lint
stylua lua/                # format
stylua --check lua/        # check formatting
busted spec/               # run tests (busted framework)
```

## Code Style

Lua: 2-space indent, 90-char max line width, single quotes, Unix line endings. See `.stylua.toml` and `.luacheckrc`.

## Architecture

### Init Sequence (`init.lua`)

Order matters — each phase depends on the previous:

1. `utils.globals` — global utility classes/functions (available everywhere without `require`)
2. `core.bootstrap` — state dirs, leader key (space), disables netrw
3. `plugins` — lazy.nvim loads all plugin specs
4. `core.cmd.auto` / `core.cmd.user` — autocmds and user commands
5. `keymap`, `core.settings`, `core.filetypes`, `core.appearance` — bindings, options, filetypes, colorscheme
6. `lsp` — language servers via mason + lspconfig + efm

All top-level requires use `Safe.require` (error handling with logging).

### Globals (`lua/utils/globals.lua`)

These are imported globally and used throughout without `require`:

- **Classes** from `toolbox` lib: `Array`, `Bool`, `Dict`, `Stream`, `String`, `Table`, `Err`, `Set`, `Lazy`, `Map`
- **Error handling**: `Safe`, `OnErr`
- **Functions**: `ternary`, `filter`, `foreach`, `map`, `fmt`
- **Logging**: `GetLogger(name)`, `GetNotify(name)`
- **Config**: `NvimConfig`

### Plugin Specs (`lua/plugins/spec/`)

11 category files: `appearance`, `code`, `editor`, `git`, `interface`, `motion`, `navigation`, `search`, `test`, `tools`, `workspace`. Pattern:

```lua
local Plugins = require('utils.plugins.plugin').plugins
return Plugins('category_name', {
  { 'author/plugin-name', opts = Config.opts(), config = Config.config },
})
```

`Plugin.all` wraps every function in each plugin def with `Safe.call` for error resilience. Config modules live in `lua/plugins/config/`.

### Keymaps (`lua/keymap/`)

All `.lua` files auto-loaded recursively. Uses custom `KeyMapper` class (`lua/utils/core/mapper.lua`) with options stacking (`:with()`/`:done()`), hydra sequences (`:with_hydra()`), and standard bindings (`:bind()`).

### LSP (`lua/lsp/`)

- `manager.lua` — server init and configuration
- `library.lua` — manifest of formatters/linters/servers per language
- `servers/` — one config file per server (e.g. `lua_ls.lua`, `pyright.lua`)
- Formatting/linting via efm-langserver with `efmls-configs-nvim`
