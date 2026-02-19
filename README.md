# Neovim

I'm a longtime vim user, nvim convert. I'm having a lot of fun (and probably spending too much time) diving into the ecosystem and crafting my setup.

- [ ] Setting up LSP related functionality, including: auto-completion, assisted refactoring, various "jump-to"/find commands, etc.
- [ ] Setting up AI/agent related functionality

## Plugin Organization

I organize my plugins into the following categories:

* **Appearance** - Appearance plugins control how nvim looks: colors, icons, textures, menus, etc. These are distinct from interface plugins in that interface elements should be functional (and ideally useful). Appearance is the place for things that provide aesthetic value only.
* **Code** - Code plugins control nvim's ability to understand, generate, and generally interact w/ code.
* **Editor** - Editor plugins control core editor capabilities like commenting, completion, general text manipulation, etc.
* **Git** - Git plugins enable nvim + git interactions/integrations.
* **Interface** - Interface plugins add to, control, or augment interface elements. Interface elements should *do something*, or at least be informational, as opposed to being purely aesthetic.
* **Motion** - Motion plugins control on-screen (as opposed to file-system) movement.
* **Navigation** - Navigation plugins control (file) system (as opposed to on-screen) movement.
* **Search** - Search plugins make it easier to find things.
* **Test** - Test plugins enable unit testing and related functionality.
* **Tools** - Tools plugins add misc functionality to nvim; they add *explicitly new* functionality to nvim, as opposed to changing something about the way its core functions work. Tools here don't fit into any other categories.
* **Workspace** - Workspace plugins control capabilities related to managing and manipulating "workspace" elements. These include buffers, tabs, windows, sessions, projects, and groupings/filtered views of the same.

## Structure

```
.
├── lua
│   ├── core
│   │   └── cmd
│   │       ├── auto
│   │       └── user
│   ├── keymap
│   │   └── plugins
│   ├── lsp
│   │   ├── library
│   │   │   └── assets
│   │   └── servers
│   ├── plugins
│   │   ├── config
│   │   └── extensions
│   └── utils
│       ├── api
│       │   └── vim
│       ├── core
│       ├── error
│       ├── plugins
│       └── reporting
├── spec
│   └── utils
│       └── core
└── spell

44 directories
```

