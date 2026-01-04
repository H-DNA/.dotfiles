> [!NOTE]
> This configuration is managed by [Stow](https://www.gnu.org/software/stow/) or via the [NixOS configuration](../../nix-config/README.md) in the root of this repository.

---

# Firefox Configuration

Firefox policies and managed bookmarks for cross-platform use.

## Structure

```
firefox/
├── policies.json        # Firefox enterprise policies
└── setup-policies.sh    # Cross-platform setup script
```

## Features

### Managed Bookmarks

The `policies.json` adds a "Tools" folder to the bookmarks toolbar with:

- **File Browser** - Opens the local File Browser web UI

### File Browser Integration

[File Browser](https://github.com/filebrowser/filebrowser) is a web-based file manager accessible via Firefox.

- **URL**: `http://localhost:41819/<secret>/files/`
- **Secret**: Generated at first boot, stored in `/var/lib/filebrowser/secret`
- **Bookmark redirect**: `~/.config/filebrowser.html`

## Installation

### NixOS

Policies are automatically applied via home-manager. The File Browser service is configured in `nix-config/hosts/common/modules/filebrowser.nix`.

### Other Linux Distros

```bash
# Run the setup script
sudo ~/.config/firefox/setup-policies.sh

# Or manually
sudo mkdir -p /etc/firefox/policies
sudo ln -sf ~/.config/firefox/policies.json /etc/firefox/policies/policies.json
```

### macOS

```bash
sudo ~/.config/firefox/setup-policies.sh
```

### Windows

Copy `policies.json` to:
```
C:\Program Files\Mozilla Firefox\distribution\policies.json
```

## File Browser Setup (Non-NixOS)

1. Install File Browser:
   ```bash
   # Arch
   yay -S filebrowser-bin

   # Or download binary
   curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash
   ```

2. Create systemd service or run manually:
   ```bash
   filebrowser --address 127.0.0.1 --port 41819 --root ~ --noauth
   ```

3. Generate the redirect file:
   ```bash
   ~/.config/scripts/update-filebrowser-bookmark
   ```

## Security

- File Browser binds to `127.0.0.1` only (no network access)
- Secret baseURL prevents CSRF attacks from malicious websites
- Command execution disabled
- No authentication (local access only)

## Documentation

- [Firefox Enterprise Policies](https://mozilla.github.io/policy-templates/)
- [File Browser](https://filebrowser.org/)
