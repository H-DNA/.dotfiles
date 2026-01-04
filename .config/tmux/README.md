# Tmux Scripts

Helper scripts for tmux configuration.

## icon.sh

Maps running commands to Nerd Font icons for the tmux status bar.

### Supported Icons

| Command | Icon | Unicode |
|---------|------|---------|
| zsh, bash, sh, fish | 󰆍 | `\uf489` |
| nvim, vim, vi |  | `\ue62b` |
| node | 󰎙 | `\ue718` |
| npm |  | `\ue71e` |
| pnpm | 󰏗 | `\uf487` |
| yarn |  | `\ue6a7` |
| bun | 󰏗 | `\uf487` |
| python |  | `\ue606` |
| ruby |  | `\ue21e` |
| git, lazygit |  | `\ue702` |
| docker |  | `\uf308` |
| ssh |  | `\uf489` |
| man, less | 󰈙 | `\uf7d9` |
| htop, btop | 󰍛 | `\uf85a` |
| make, cmake |  | `\ue615` |
| cargo |  | `\ue7a8` |
| go |  | `\ue626` |
| rustc |  | `\ue7a8` |
| lua | 󰢱 | `\ue620` |
| deno |  | `\ue628` |
| (default) |  | `\uf120` |

### Adding New Icons

Edit `icon.sh` and add a new case:

```bash
case "$1" in
  # ... existing cases ...
  mycommand) printf '\uXXXX' ;;  # Find icon code at nerdfonts.com
  # ...
esac
```

### Usage

The script is called by tmux's `window-status-format`:

```tmux
set -g window-status-format "#(~/.config/tmux/icon.sh #{pane_current_command}) #W"
```

### Dependencies

- JetBrainsMono Nerd Font (or any Nerd Font)
