> [!NOTE]
> This configuration is managed by [Stow](https://www.gnu.org/software/stow/) or via the [NixOS configuration](../../nix-config/README.md) in the root of this repository.

---

# Neovim Configuration

A modular Neovim configuration using Lazy.nvim for plugin management.

## Structure

```
nvim/
├── init.lua              # Entry point
└── lua/
    ├── core/
    │   ├── init.lua      # Core settings loader
    │   ├── keymaps.lua   # Key bindings
    │   └── lazy.lua      # Plugin manager bootstrap
    └── plugins/
        ├── specs/        # Plugin specifications (lazy.nvim format)
        └── configs/      # Plugin configurations
            ├── lsp/      # Language server setup
            ├── editor/   # Editor enhancements
            ├── ui/       # UI customizations
            ├── git/      # Git integration
            ├── completion/   # Autocompletion
            └── formatting/   # Code formatting
```

## Key Features

- **LSP**: Mason-managed + Nix-provided servers (nil for Nix)
- **Completion**: nvim-cmp with LSP, snippets, path, buffer, and cmdline sources
- **Treesitter**: Syntax highlighting and code navigation
- **Telescope**: Fuzzy finder for files, grep, and more
- **Git**: Gitsigns, fugitive, lazygit integration
- **Editing**: Comment.nvim, nvim-surround, nvim-autopairs
- **Formatting**: Format-on-save with stylua, prettier, black, gofumpt
- **Diagnostics**: Inline virtual text with Nerd Font icons

## Adding a New LSP Server

### Mason-managed (most languages)

1. Add server name to `lua/plugins/configs/lsp/mason.lua`
2. Optionally add custom config in `lua/plugins/configs/lsp/servers/<server>.lua`

### Nix-provided (like nil for Nix)

1. Add to `nix_servers` in `lua/plugins/configs/lsp/servers/init.lua`
2. Create config file `lua/plugins/configs/lsp/servers/<server>.lua`
3. Add package to `home/<user>/packages.nix`

## Key Bindings

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>e` | File explorer |
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover documentation |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |
| `gcc` | Toggle line comment |
| `gc` | Toggle comment (visual) |
| `ys{motion}{char}` | Add surround |
| `ds{char}` | Delete surround |
| `cs{old}{new}` | Change surround |
| `<leader>r` | Run code |
| `<leader>rf` | Run file |
| `<leader>rp` | Run project |

## Documentation

- [Neovim](https://neovim.io/doc/)
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [Mason](https://github.com/williamboman/mason.nvim)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
