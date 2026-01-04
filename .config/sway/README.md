> [!NOTE]
> This configuration is managed by [Stow](https://www.gnu.org/software/stow/) or via the [NixOS configuration](../../nix-config/README.md) in the root of this repository.

---

# Sway Configuration

Sway is a tiling Wayland compositor compatible with i3. This config uses a Gruvbox color scheme with cozy gaps and ergonomic keybindings.

## Structure

```
sway/
├── config              # Main configuration file
├── scripts/            # Helper scripts (wallpaper, etc.)
└── nixdog/background/  # Wallpapers
```

## Key Bindings

### Core

| Key | Action |
|-----|--------|
| `$mod+t` | Open terminal (ghostty) |
| `$mod+q` | Kill focused window |
| `$mod+Space` | Application launcher (wofi) |
| `$mod+c` | Reload config |
| `$mod+Shift+e` | Exit sway |
| `$mod+Escape` | Lock screen |

### Quick Launchers

| Key | Action |
|-----|--------|
| `$mod+b` | Open Firefox |
| `$mod+n` | Open Nautilus (file manager) |
| `$mod+Shift+n` | Toggle notification center |

### Navigation (vim-style)

| Key | Action |
|-----|--------|
| `$mod+h/j/k/l` | Focus left/down/up/right |
| `$mod+Shift+h/j/k/l` | Move window left/down/up/right |
| `$mod+1-0` | Switch to workspace 1-10 |
| `$mod+Shift+1-0` | Move window to workspace 1-10 |
| `$mod+Return` | Toggle focus between tiling/floating |
| `$mod+a` | Focus parent container |

### Layout

| Key | Action |
|-----|--------|
| `$mod+v` | Split vertically |
| `$mod+g` | Split horizontally |
| `$mod+s` | Stacking layout |
| `$mod+w` | Tabbed layout |
| `$mod+e` | Toggle split |
| `$mod+f` | Toggle fullscreen |
| `$mod+d` | Toggle floating |
| `$mod+Shift+s` | Sticky window (all workspaces) |
| `$mod+r` | Resize mode |

### Scratchpad

| Key | Action |
|-----|--------|
| `$mod+minus` | Show scratchpad |
| `$mod+Shift+minus` | Move to scratchpad |

### Utilities

| Key | Action |
|-----|--------|
| `Print` | Screenshot (full, clipboard) |
| `Shift+Print` | Screenshot (selection, clipboard) |
| `$mod+Print` | Screenshot (full, save) |
| `$mod+Shift+Print` | Screenshot (selection, save) |
| `$mod+Shift+w` | Random wallpaper |
| `XF86Audio*` | Volume controls |
| `XF86MonBrightness*` | Brightness controls |

## Appearance

- **Theme**: Gruvbox
- **Gaps**: 8px inner, 4px outer (smart gaps enabled)
- **Borders**: 2px pixel borders
- **Cursor**: Bibata-Modern-Classic
- **Font**: JetBrainsMono Nerd Font

## Behavior

- Focus follows mouse
- Mouse warps to focused container
- Workspace back-and-forth (press same workspace key to return)
- Smart gaps (disabled when single window)

## Dependencies

- `swaync` - Notification center
- `swww` - Wallpaper daemon
- `swaylock` - Screen locker
- `swayidle` - Idle management
- `waybar` - Status bar
- `wofi` - Application launcher
- `grim` + `slurp` - Screenshots
- `fcitx5` - Input method
- `bibata-cursors` - Cursor theme

## Documentation

- [Sway Wiki](https://github.com/swaywm/sway/wiki)
- [Sway Man Page](https://man.archlinux.org/man/sway.5)
- [i3 User Guide](https://i3wm.org/docs/userguide.html) (mostly compatible)
