> [!NOTE]
> This configuration is managed by [Stow](https://www.gnu.org/software/stow/) or via the [NixOS configuration](../../nix-config/README.md) in the root of this repository.

---

# Wofi Configuration

Wofi is a launcher/menu for wlroots-based Wayland compositors.

## Structure

```
wofi/
├── config           # Behavior configuration
└── style.css        # Styling
```

## Usage

```bash
# Application launcher
wofi --show drun

# Run command
wofi --show run

# dmenu mode (stdin)
echo -e "option1\noption2" | wofi --show dmenu
```

## Common Settings (config)

```ini
# Appearance
width=600
height=400
location=center
allow_images=true
image_size=32

# Behavior
allow_markup=true
insensitive=true
prompt=Search...

# Modes
show=drun
```

## Styling (style.css)

```css
window {
  background-color: #282828;
  border-radius: 8px;
}

#input {
  background-color: #3c3836;
  color: #ebdbb2;
  border: none;
  padding: 10px;
}

#entry:selected {
  background-color: #458588;
}
```

## Documentation

- [Wofi Man Page](https://man.archlinux.org/man/wofi.1)
- [Wofi GitHub](https://hg.sr.ht/~scoopta/wofi)
- [Wofi Styling](https://man.archlinux.org/man/wofi.5)
