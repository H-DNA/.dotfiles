> [!NOTE]
> This configuration is managed by [Stow](https://www.gnu.org/software/stow/) or via the [NixOS configuration](../../nix-config/README.md) in the root of this repository.

---

# Ghostty Configuration

Ghostty is a fast, native terminal emulator built with Zig.

## Structure

```
ghostty/
└── config           # Main configuration
```

## Key Bindings

| Key | Action |
|-----|--------|
| `Ctrl+Shift+c` | Copy |
| `Ctrl+Shift+v` | Paste |
| `Ctrl+Shift+t` | New tab |
| `Ctrl+Shift+w` | Close tab |
| `Ctrl+Shift+n` | New window |
| `Ctrl+Tab` | Next tab |
| `Ctrl+Shift+Tab` | Previous tab |

## Common Settings

```
# Font
font-family = JetBrainsMono Nerd Font
font-size = 12

# Window
window-padding-x = 10
window-padding-y = 10

# Theme
theme = gruvbox-dark

# Scrollback
scrollback-limit = 10000
```

## Documentation

- [Ghostty Website](https://ghostty.org/)
- [Ghostty GitHub](https://github.com/ghostty-org/ghostty)
- [Configuration Reference](https://ghostty.org/docs/config)
