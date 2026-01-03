> [!NOTE]
> This configuration is managed by [Stow](https://www.gnu.org/software/stow/) or via the [NixOS configuration](../../nix-config/README.md) in the root of this repository.

---

# Alacritty Configuration

Alacritty is a fast, cross-platform terminal emulator.

## Structure

```
alacritty/
└── alacritty.toml   # Main configuration (TOML format)
```

## Key Bindings

| Key | Action |
|-----|--------|
| `Ctrl+Shift+c` | Copy |
| `Ctrl+Shift+v` | Paste |
| `Ctrl+Shift+n` | New window |
| `Ctrl+Shift+Space` | Vi mode |
| `Ctrl++` / `Ctrl+-` | Zoom in/out |
| `Ctrl+0` | Reset zoom |

## Common Settings

```toml
[font]
normal = { family = "JetBrainsMono Nerd Font", style = "Regular" }
size = 12.0

[window]
padding = { x = 10, y = 10 }
decorations = "None"
opacity = 0.95

[scrolling]
history = 10000

[colors]
# See themes at github.com/alacritty/alacritty-theme
```

## Documentation

- [Alacritty GitHub](https://github.com/alacritty/alacritty)
- [Configuration Reference](https://alacritty.org/config-alacritty.html)
- [Alacritty Themes](https://github.com/alacritty/alacritty-theme)
