# Swaylock Configuration

Screen locker for Sway, using [swaylock-effects](https://github.com/mortie/swaylock-effects) for additional features like blur and vignette.

## Features

- Gruvbox color theme matching the rest of the desktop
- Background blur and vignette effects
- Colored ring indicator showing lock state
- JetBrainsMono Nerd Font

## Ring Colors

| State | Color |
|-------|-------|
| Idle | Gray (`#504945`) |
| Key press | Green (`#98971a`) |
| Backspace | Red (`#cc241d`) |
| Caps Lock | Yellow (`#d79921`) |
| Verifying | Blue (`#458588`) |
| Wrong | Red (`#cc241d`) |
| Cleared | Yellow (`#d79921`) |

## Dependencies

- `swaylock-effects` (not regular `swaylock`)
- JetBrainsMono Nerd Font

## Usage

```bash
# Lock screen
swaylock

# Lock with custom image
swaylock -i /path/to/image.jpg
```

## Keybinding

In sway config:
- `$mod+Escape` - Lock screen manually
- Auto-locks after 240 seconds of idle
