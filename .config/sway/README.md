> [!NOTE]
> This configuration is managed by [Stow](https://www.gnu.org/software/stow/) or via the [NixOS configuration](../../nix-config/README.md) in the root of this repository.

---

# Sway Configuration

Sway is a tiling Wayland compositor compatible with i3.

## Structure

```
sway/
└── config           # Main configuration file
```

## Key Bindings

| Key | Action |
|-----|--------|
| `$mod+Return` | Open terminal |
| `$mod+d` | Application launcher (wofi) |
| `$mod+Shift+q` | Kill focused window |
| `$mod+h/j/k/l` | Focus left/down/up/right |
| `$mod+Shift+h/j/k/l` | Move window |
| `$mod+1-9` | Switch workspace |
| `$mod+Shift+1-9` | Move to workspace |
| `$mod+f` | Toggle fullscreen |
| `$mod+Shift+space` | Toggle floating |
| `$mod+r` | Resize mode |
| `$mod+Shift+e` | Exit sway |
| `$mod+Shift+c` | Reload config |

## Customization

Common settings to customize:

```bash
# Modifier key ($mod)
set $mod Mod4  # Super/Windows key

# Terminal
set $term kitty

# Wallpaper
output * bg /path/to/wallpaper.jpg fill

# Gaps
gaps inner 10
gaps outer 5
```

## Documentation

- [Sway Wiki](https://github.com/swaywm/sway/wiki)
- [Sway Man Page](https://man.archlinux.org/man/sway.5)
- [i3 User Guide](https://i3wm.org/docs/userguide.html) (mostly compatible)
