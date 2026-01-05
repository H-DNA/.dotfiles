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
| **Firefox** | `.config/firefox/` | Browser policies & bookmarks |
| **EWW** | `.config/eww/` | Capture toolbar (screenshots/recording) |
| **Fcitx5** | `.config/fcitx5/` | Input method framework |
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
| `$mod+b` | Open Firefox |
| `$mod+n` | Open Nautilus |
| `$mod+Shift+n` | Toggle notification center |

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
| `$mod+Shift+s` | Toggle sticky (show on all workspaces) |
| `$mod+Return` | Toggle focus tiling/floating |
| `$mod+r` | Resize mode |
| `$mod+v` | Split vertical |
| `$mod+g` | Split horizontal |
| `$mod+s/w/e` | Stacking/tabbed/split layout |
| `$mod+a` | Focus parent container |

### Scratchpad
| Key | Action |
|-----|--------|
| `$mod+-` | Show scratchpad |
| `$mod+Shift+-` | Move to scratchpad |
| `$mod+m` | Toggle Spotify |

### Utilities
| Key | Action |
|-----|--------|
| `Print` | Capture toolbar |
| `$mod+Shift+p` | Capture toolbar |
| `$mod+Shift+w` | Random wallpaper |
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
│   │   ├── scripts/    # wallpaper, capture toolbar
│   │   └── nixdog/     # backgrounds, avatars
│   ├── swaylock/       # Lock screen
│   ├── swaync/         # Notifications
│   ├── tmux/           # Tmux helper scripts
│   ├── waybar/         # Status bar + recording status
│   ├── wofi/           # Launcher
│   ├── eww/            # Capture toolbar widgets
│   ├── fcitx5/         # Input method framework
│   ├── firefox/        # Browser policies
│   ├── scripts/        # Shared utility scripts
│   └── mimeapps.list   # Default applications
├── .local/share/
│   └── applications/   # Custom .desktop files
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
- wf-recorder, ffmpeg (screen recording)
- eww (capture toolbar)
- brightnessctl, pavucontrol, blueman
- tmux, neovim
- filebrowser (optional, web file manager)

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

## Capture Toolbar

EWW-based toolbar for screenshots and screen recording. Open with `Print` or `$mod+Shift+p`.

### Features

- **Screenshot**: Click to capture fullscreen, drag to select region
- **Screen Recording**: With optional system audio and/or microphone
- **Voice Recording**: Audio-only recording
- **Pause/Resume**: Segment-based pause for video recordings
- **File Browser**: Quick access to captured media

### Waybar Integration

Recording status appears in waybar with:
- Recording duration timer
- Audio source indicators (system/mic)
- Pause/resume and stop buttons

### Media Storage

```
~/Media/
├── screenshots/    # PNG screenshots
├── recordings/     # MP4 screen recordings
└── voice/          # MP3 voice recordings
```

## File Browser

Web-based file manager accessible via Firefox at `localhost:41819`.

### Setup (Non-NixOS)

```bash
# Install
curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash

# Run (or create systemd service)
filebrowser --address 127.0.0.1 --port 41819 --root ~ --noauth

# Setup Firefox bookmark
~/.config/scripts/update-filebrowser-bookmark
```

### Security

- Localhost only (127.0.0.1)
- Secret baseURL (CSRF protection)
- Command execution disabled

See [.config/firefox/README.md](./.config/firefox/README.md) for details.
