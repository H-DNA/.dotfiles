> [!NOTE]
> This configuration is managed by [Stow](https://www.gnu.org/software/stow/) or via the [NixOS configuration](../../nix-config/README.md) in the root of this repository.

---

# Waybar Configuration

Waybar is a customizable status bar for Wayland compositors.

## Structure

```
waybar/
├── config           # Module configuration (JSON)
├── style.css        # Styling (CSS/GTK)
└── scripts/         # Custom module scripts
    ├── system-stats.sh
    └── pulseaudio.sh
```

## Modules

| Module | Description |
|--------|-------------|
| `sway/workspaces` | Workspace indicators |
| `sway/window` | Active window title |
| `clock` | Date and time |
| `battery` | Battery status |
| `network` | WiFi/Ethernet status |
| `custom/pulseaudio` | Volume control |
| `tray` | System tray |
| `custom/stats` | System stats launcher |

## Customization

### Adding a Module

1. Add module name to `modules-left`, `modules-center`, or `modules-right` in `config`
2. Configure the module in `config`
3. Style it in `style.css` using `#module-name` selector

### Custom Modules

Custom modules use scripts that output JSON:

```bash
echo '{"text": "icon", "tooltip": "info", "class": "state"}'
```

### Styling

Uses GTK CSS. Key selectors:

```css
#module-name { }           /* Base style */
#module-name.class { }     /* Class-based (from JSON) */
#module-name:hover { }     /* Hover state */
```

## Interactions

- **Left click**: Primary action (e.g., toggle format)
- **Right click**: Secondary action (e.g., open settings)
- **Scroll**: Adjust value (e.g., volume)

## Documentation

- [Waybar Wiki](https://github.com/Alexays/Waybar/wiki)
- [Waybar Configuration](https://github.com/Alexays/Waybar/wiki/Configuration)
- [Waybar Styling](https://github.com/Alexays/Waybar/wiki/Styling)
- [GTK CSS Reference](https://docs.gtk.org/gtk3/css-overview.html)
