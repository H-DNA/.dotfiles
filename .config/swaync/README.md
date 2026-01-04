# SwayNC Configuration

[Sway Notification Center](https://github.com/ErikReider/SwayNotificationCenter) - A notification daemon and control center for Sway.

## Features

- Gruvbox color theme
- Notification popups with actions
- Control center with quick settings

## Widgets

The control center includes these widgets:

| Widget | Description |
|--------|-------------|
| **Inhibitors** | Shows apps preventing idle/sleep |
| **Title** | Header with "Clear All" button |
| **DND** | Do Not Disturb toggle |
| **Notifications** | Notification list |
| **MPRIS** | Media player controls |
| **Volume** | Volume slider |
| **Backlight** | Brightness slider |
| **Buttons Grid** | Quick action buttons |

## Quick Action Buttons

| Icon | Action |
|------|--------|
| 󰖩 | Network settings (`nm-connection-editor`) |
| 󰂯 | Bluetooth (`blueman-manager`) |
| 󰌪 | Power Saver mode |
| 󰛲 | Balanced mode |
| 󰓅 | Performance mode |
| 󰌾 | Lock screen |
| 󰐥 | Power off |
| 󰜉 | Reboot |

## Usage

```bash
# Toggle control center
swaync-client -t

# Close all notifications
swaync-client -C

# Toggle DND
swaync-client -d

# Reload config
swaync-client -rs
```

## Waybar Integration

Most waybar modules open the notification center on click:
- Clock, Battery, CPU, Memory, Backlight → Left click opens control center
- Network → Left click opens `nm-connection-editor`, right click opens control center
- Volume → Left click opens `pavucontrol`, middle click opens control center

## Dependencies

- `swaynotificationcenter`
- `blueman` (for Bluetooth button)
- `networkmanagerapplet` (for Network button)
- `pavucontrol` (for volume control)
