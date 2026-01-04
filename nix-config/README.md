# NixOS Configuration

A modular NixOS configuration with Home Manager, secrets management, and hardware optimizations.

## Quick Start

```bash
# Build and switch to the configuration
sudo nixos-rebuild switch --flake .#x86_64-linux

# Update flake inputs
nix flake update

# Format all nix files
nix fmt
```

## Directory Structure

```
nix-config/
├── flake.nix                    # Main entry point, defines inputs and outputs
├── flake.lock                   # Locked dependency versions
├── README.md                    # This file
├── overlays/
│   └── default.nix              # Custom package overlays
├── secrets/
│   ├── secrets.nix              # Agenix secret declarations
│   └── *.age                    # Encrypted secret files
├── home/
│   └── <username>/
│       ├── default.nix          # User's Home Manager config
│       └── packages.nix         # User-specific packages
└── hosts/
    ├── default.nix              # Host configuration router
    ├── common/
    │   ├── default.nix          # Shared configuration for all hosts
    │   └── modules/             # Reusable NixOS modules
    └── <arch>/
        ├── default.nix          # Architecture-specific config
        ├── hardware-configuration.nix
        └── modules/             # Host-specific modules
```

## Configuration Layers

### 1. System Configuration (NixOS)

Located in `hosts/`. Contains:
- Boot configuration
- System services
- Hardware settings
- Network configuration
- System-wide packages

### 2. User Configuration (Home Manager)

Located in `home/<username>/`. Contains:
- User packages
- Dotfiles
- Shell configuration
- Git configuration
- Application settings

## Adding a New Host

1. Add the architecture to `hosts` list in `flake.nix`:
   ```nix
   hosts = [ "x86_64-linux" "aarch64-linux" ];
   ```

2. Create the host directory:
   ```bash
   mkdir -p hosts/<arch>/modules
   ```

3. Create `hosts/<arch>/default.nix` with host-specific configuration

4. Generate and add `hardware-configuration.nix`:
   ```bash
   nixos-generate-config --show-hardware-config > hosts/<arch>/hardware-configuration.nix
   ```

5. Create `hosts/<arch>/modules/default.nix` for additional modules

## Adding a New User

1. Create the home directory:
   ```bash
   mkdir -p home/<username>
   ```

2. Create `home/<username>/default.nix`:
   ```nix
   { pkgs, ... }:
   {
     imports = [ ./packages.nix ];
     home = {
       username = "<username>";
       homeDirectory = "/home/<username>";
       stateVersion = "25.05";
     };
     programs.home-manager.enable = true;
   }
   ```

3. Create `home/<username>/packages.nix` with user packages

4. Add user to flake.nix home-manager configuration

## Secrets Management (Agenix)

Secrets are encrypted using [agenix](https://github.com/ryantm/agenix) and stored in `secrets/`.

### Editing Secrets

```bash
# Edit an existing secret
nix run github:ryantm/agenix -- -e secrets/<name>.age

# Create a new secret
nix run github:ryantm/agenix -- -e secrets/new-secret.age
```

### Adding a New Secret

1. Declare the secret in `secrets/secrets.nix`:
   ```nix
   {
     "new-secret.age".publicKeys = all;
   }
   ```

2. Create and encrypt the secret:
   ```bash
   nix run github:ryantm/agenix -- -e secrets/new-secret.age
   ```

3. Reference in your configuration:
   ```nix
   age.secrets.new-secret = {
     file = ../../secrets/new-secret.age;
     mode = "0400";
   };
   ```

### Rekeying Secrets

When adding new keys or changing `secrets.nix`:
```bash
nix run github:ryantm/agenix -- -r
```

## Overlays

Custom package modifications go in `overlays/default.nix`:

```nix
[
  (final: prev: {
    # Override an existing package
    mypackage = prev.mypackage.overrideAttrs (old: {
      patches = old.patches or [] ++ [ ./my-fix.patch ];
    });

    # Add a new package
    my-tool = prev.callPackage ./pkgs/my-tool { };
  })
]
```

## Flake Commands Reference

| Command | Description |
|---------|-------------|
| `sudo nixos-rebuild switch --flake .#<host>` | Build and activate configuration |
| `sudo nixos-rebuild boot --flake .#<host>` | Build and set as boot default |
| `sudo nixos-rebuild test --flake .#<host>` | Build and activate without boot entry |
| `nix flake update` | Update all flake inputs |
| `nix flake update <input>` | Update specific input |
| `nix fmt` | Format all nix files |
| `nix flake check` | Run flake checks |
| `nix build .#nixosConfigurations.<host>.config.system.build.toplevel` | Build without switching |

## Conventions

### File Naming
- Use `default.nix` for directory entry points
- Use descriptive names for single-purpose modules (e.g., `git.nix`, `ssh.nix`)
- Use `.age` extension for encrypted secrets

### Module Structure
- Each module should be self-contained
- Use `imports` to compose modules
- Pass configuration via `specialArgs` for flake inputs

### Package Placement
- **System packages** (`environment.systemPackages`): Tools needed by all users or at boot
- **User packages** (`home.packages`): User-specific applications and tools

### Secrets
- Never commit plaintext secrets
- Use descriptive names for secret files
- Document secret purposes in `secrets.nix`

## Maintenance

### Garbage Collection

Automatic garbage collection is enabled:
- Runs weekly
- Removes generations older than 30 days

Manual cleanup:
```bash
# Remove old generations
sudo nix-collect-garbage -d

# Remove generations older than 7 days
sudo nix-collect-garbage --delete-older-than 7d
```

### Store Optimization

Automatic store optimization (deduplication) is enabled. Manual run:
```bash
nix-store --optimise
```

## Troubleshooting

### Fonts Not Loading
```bash
fc-cache -f -v
```

### Build Errors
```bash
# Check flake evaluation
nix flake check

# Build with verbose output
sudo nixos-rebuild switch --flake .#<host> --show-trace
```

### Secrets Not Decrypting
1. Ensure SSH key exists: `ls ~/.ssh/id_ed25519`
2. Verify key is in `secrets/secrets.nix`
3. Rekey if needed: `nix run github:ryantm/agenix -- -r`

### Home Manager Issues
```bash
# Rebuild home-manager only
home-manager switch --flake .#<username>

# Check home-manager status
home-manager generations
```

## Inputs

| Input | Description |
|-------|-------------|
| `nixpkgs` | NixOS unstable channel |
| `home-manager` | User environment management |
| `nixos-hardware` | Hardware-specific optimizations |
| `agenix` | Secrets management |
| `disko` | Declarative disk partitioning (available for future use) |
