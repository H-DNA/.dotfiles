# Dotfiles

Personal dotfiles for a Linux environment running Sway (Wayland compositor) with a Gruvbox color theme.

## Management

Configurations are managed in two ways:
1. **Stow**: For symlinking configs directly into the home directory
2. **Nix & Home Manager**: For declarative, reproducible system setup (see `nix-config/`)

## Managed Applications

| Application | Location | Description |
|-------------|----------|-------------|
| **Alacritty** | `.config/alacritty/` | GPU-accelerated terminal |
| **Ghostty** | `.config/ghostty/` | Modern terminal emulator |
| **Kitty** | `.config/kitty/` | Feature-rich terminal |
| **Neovim** | `.config/nvim/` | Extensible text editor |
| **Sway** | `.config/sway/` | Tiling Wayland compositor |
| **Waybar** | `.config/waybar/` | Status bar for Sway |
| **Wofi** | `.config/wofi/` | Application launcher |
| **Swaylock** | `.config/swaylock/` | Screen locker (effects) |
| **SwayNC** | `.config/swaync/` | Notification center |
| **Tmux** | `.tmux.conf`, `.config/tmux/` | Terminal multiplexer |
| **Zsh** | `.zshrc.base` | Shell configuration |
| **NixOS** | `nix-config/` | System configuration |

## Sway Keybindings

### General
| Key | Action |
|-----|--------|
| `$mod+t` | Open terminal |
| `$mod+Space` | App launcher (wofi) |
| `$mod+q` | Kill window |
| `$mod+c` | Reload config |
| `$mod+Escape` | Lock screen |
| `$mod+Shift+e` | Exit sway |

### Navigation
| Key | Action |
|-----|--------|
| `$mod+h/j/k/l` | Focus left/down/up/right |
| `$mod+1-0` | Switch to workspace 1-10 |
| `$mod+Shift+1-0` | Move window to workspace |

### Window Management
| Key | Action |
|-----|--------|
| `$mod+Shift+h/j/k/l` | Move window |
| `$mod+f` | Fullscreen |
| `$mod+d` | Toggle floating |
| `$mod+Return` | Toggle focus tiling/floating |
| `$mod+r` | Resize mode |
| `$mod+s/w/e` | Stacking/tabbed/split layout |

### Scratchpad
| Key | Action |
|-----|--------|
| `$mod+-` | Show scratchpad |
| `$mod+Shift+-` | Move to scratchpad |

### Utilities
| Key | Action |
|-----|--------|
| `Print` | Screenshot (full, clipboard) |
| `Shift+Print` | Screenshot (area, clipboard) |
| `$mod+Print` | Screenshot (full, file) |
| `$mod+Shift+Print` | Screenshot (area, file) |
| `$mod+b` | Random wallpaper |
| `XF86Audio*` | Volume controls |
| `XF86MonBrightness*` | Brightness controls |

## Tmux Keybindings

Prefix: `Ctrl+s`

| Key | Action |
|-----|--------|
| `prefix+r` | Reload config |
| `prefix+q` | Enter copy mode |
| `prefix+h/j/k/l` | Navigate panes (vim-tmux-navigator) |

## Directory Structure

```
.
├── .config/
│   ├── alacritty/      # Terminal config
│   ├── ghostty/        # Terminal config
│   ├── kitty/          # Terminal config
│   ├── nvim/           # Neovim (Lua-based)
│   ├── sway/           # Compositor + scripts
│   │   ├── config
│   │   ├── scripts/    # wallpaper script
│   │   └── nixdog/     # backgrounds, avatars
│   ├── swaylock/       # Lock screen
│   ├── swaync/         # Notifications
│   ├── tmux/           # Tmux helper scripts
│   ├── waybar/         # Status bar
│   └── wofi/           # Launcher
├── nix-config/         # NixOS configuration
│   ├── flake.nix       # Entry point
│   ├── hosts/          # System configs
│   ├── home/           # User configs
│   ├── overlays/       # Package overrides
│   └── secrets/        # Encrypted secrets
├── .tmux.conf          # Tmux configuration
├── .zshrc.base         # Zsh configuration
└── .gitconfig          # Git configuration
```

## Installation

### Using Stow (non-NixOS)

```bash
# Clone
git clone https://github.com/H-DNA/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Symlink everything
stow .

# Or specific configs
stow nvim
```

**Dependencies:**
- JetBrainsMono Nerd Font
- sway, swaylock-effects, swww, waybar, wofi, swaync
- grim, slurp, wl-clipboard (screenshots)
- brightnessctl, pavucontrol, blueman
- tmux, neovim

### Using NixOS

```bash
# Clone to dotfiles
git clone https://github.com/H-DNA/dotfiles.git ~/dotfiles

# Build and switch
sudo nixos-rebuild switch --flake ~/dotfiles/nix-config#x86_64-linux
```

See [nix-config/README.md](./nix-config/README.md) for detailed NixOS documentation.

## Color Theme

All configurations use the **Gruvbox** color scheme:

| Color | Hex | Usage |
|-------|-----|-------|
| bg0 | `#1d2021` | Background |
| bg1 | `#3c3836` | Surface |
| bg2 | `#504945` | Surface variant |
| fg | `#ebdbb2` | Text |
| red | `#cc241d` | Errors, urgent |
| green | `#98971a` | Success |
| yellow | `#d79921` | Warnings |
| blue | `#458588` | Info, focused |
| purple | `#b16286` | Special |
| aqua | `#689d6a` | Secondary |
| orange | `#d65d0e` | Accent |
| gray | `#928374` | Muted |
