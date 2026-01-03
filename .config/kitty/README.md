> [!NOTE]
> This configuration is managed by [Stow](https://www.gnu.org/software/stow/) or via the [NixOS configuration](../../nix-config/README.md) in the root of this repository.

---

# Kitty Configuration

Kitty is a fast, GPU-accelerated terminal emulator.

## Structure

```
kitty/
└── kitty.conf       # Main configuration
```

## Key Bindings

| Key | Action |
|-----|--------|
| `Ctrl+Shift+c` | Copy |
| `Ctrl+Shift+v` | Paste |
| `Ctrl+Shift+t` | New tab |
| `Ctrl+Shift+q` | Close tab |
| `Ctrl+Shift+Enter` | New window (split) |
| `Ctrl+Shift+]` / `[` | Next/previous tab |
| `Ctrl+Shift+f` | Search |
| `Ctrl+Shift+u` | Unicode input |
| `Ctrl+Shift+f5` | Reload config |

## Common Settings

```conf
# Font
font_family      JetBrainsMono Nerd Font
font_size        12.0

# Window
window_padding_width 10
hide_window_decorations yes

# Scrollback
scrollback_lines 10000

# URLs
url_style curly
open_url_with default
```

## Documentation

- [Kitty Documentation](https://sw.kovidgoyal.net/kitty/)
- [Kitty Config Reference](https://sw.kovidgoyal.net/kitty/conf/)
- [Kitty FAQ](https://sw.kovidgoyal.net/kitty/faq/)
