# Dotfiles

This repository contains my personal dotfiles and configurations for various tools, primarily for a Linux environment running a Wayland compositor.

The configurations are managed in two ways:
1.  **Stow**: For simple, standalone configurations that can be symlinked directly into the home directory.
2.  **Nix & Home Manager**: For a more declarative and reproducible setup, especially for system-level configurations and managing packages. The Nix configuration is located in the `nix-config` directory.

## Managed applications

| Application | Configuration Location | Managed By | Description |
| :--- | :--- | :--- | :--- |
| **Alacritty** | `.config/alacritty/` | Stow / Nix | A fast, GPU-accelerated terminal emulator. |
| **Ghostty** | `.config/ghostty/` | Stow / Nix | A modern, GPU-accelerated terminal emulator. |
| **Kitty** | `.config/kitty/` | Stow / Nix | A feature-rich, GPU-based terminal emulator. |
| **Neovim** | `.config/nvim/` | Stow / Nix | A highly extensible, Vim-based text editor. |
| **Sway** | `.config/sway/` | Stow / Nix | A tiling Wayland compositor, i3-compatible. |
| **Waybar** | `.config/waybar/` | Stow / Nix | A highly customizable Wayland bar for Sway. |
| **Wofi** | `.config/wofi/` | Stow / Nix | A launcher/menu for Wayland compositors. |
| **Tmux** | `.tmux.conf` | Stow / Nix | A terminal multiplexer. |
| **Zsh** | `.zshrc`, `.zshrc.base` | Stow / Nix | The Z shell. |
| **NixOS** | `nix-config/` | Nix | The entire system configuration. |

---

## Codebase structure

This repository is a "dotfiles" monorepo, meaning it stores all your configuration files for various applications in one place. It uses a hybrid approach for managing these configurations: `stow` for simple symlinking and `Nix/home-manager` for a fully declarative and reproducible environment.

### High-level structure

```
.
├── .config/             # Configurations for most GUI and terminal applications
├── nix-config/          # A complete, declarative NixOS and home-manager setup
├── .tmux.conf           # Configuration for the tmux terminal multiplexer
├── .zshrc.base          # Base Zsh configuration, sourced by .zshrc
├── .zshrc.example       # Example Zsh file for local/private settings
├── README.md            # Main README explaining the repository
└── ...                  # Other dotfiles like .gitconfig, .gitignore etc.
```

---

### 1. Root directory

The root directory contains configuration files that typically reside directly in the user's home directory (`~`).

-   **`.tmux.conf`**: The configuration file for `tmux`.
-   **`.zshrc.base`**: Contains the main, shareable Zsh shell configuration.
-   **`.zshrc.example`**: A template for creating a `.zshrc` file. This is meant to be copied to `.zshrc` and is a good place to put machine-specific or private environment variables, so they don't get committed to version control.
-   **`.stow-local-ignore`**: Tells `stow` to ignore certain files when creating symlinks, like the main `README.md`.

These files are intended to be managed by `stow`, which will create symlinks to them from your home directory.

---

### 2. `.config` directory

This directory follows the XDG Base Directory Specification, storing configurations for many applications inside `~/.config/`. Each folder within corresponds to an application.

-   **`alacritty/`**, **`ghostty/`**, **`kitty/`**: Configurations for different terminal emulators. You can easily switch between them.
-   **`nvim/`**: A highly customized Neovim setup. This is a complex configuration in itself, with a modular structure using Lua.
    -   `init.lua`: The entry point.
    -   `lua/core/`: Core settings, keymaps, and the plugin manager (`lazy.nvim`).
    -   `lua/plugins/`: Plugin configurations, separated by category (LSP, UI, completion, etc.).
-   **`sway/`**, **`waybar/``, `wofi/`**: Configurations for a complete Wayland desktop environment (compositor, status bar, and application launcher).

Like the files in the root, these are also manageable via `stow`. For example, `stow nvim` would symlink the `nvim` directory to `~/.config/nvim`.

---

### 3. `nix-config` directory

This is the most complex part of the repository. It contains a complete, declarative system configuration using **NixOS** and **Home Manager**. This allows you to rebuild your entire system and user environment from these files.

-   **`flake.nix`**: The entry point for the Nix configuration. It defines the repository's "outputs," which are your system configurations, and manages dependencies (inputs) like `nixpkgs` and `home-manager`.
-   **`hosts/`**: Contains system-level configurations for different machines (or "hosts").
    -   `common/`: Modules and settings that are shared across all your machines.
    -   `x86_64-linux/`: Configuration specific to a machine with that architecture. This is where you'd define hardware-specific settings.
-   **`home/`**: Contains user-level configurations managed by `home-manager`.
    -   `huydna/`: This is your user-specific configuration. It defines packages to install, dotfiles to manage, services to run, etc., for your user account.
-   **`overlays/`**: Allows you to customize or override packages in `nixpkgs`.
-   **`secrets/`**: Managed by `agenix` for encrypting and decrypting secrets like API keys or passwords.
-   **`README.md`**: A very detailed guide on how to use and maintain this Nix setup.

## Installation

There are two ways to use this repository, depending on your setup.

### 1. Stow (for non-NixOS systems)

This method uses GNU Stow to symlink the configuration files into your home directory.

**Prerequisites:**
*   `stow`
*   `git`
*   The required fonts (e.g., `JetBrainsMono Nerd Font`)
*   The applications themselves (e.g., `alacritty`, `nvim`, etc.)

**Steps:**

1.  Clone the repository:
    ```sh
    git clone https://github.com/H-DNA/.dotfiles.git ~/.dotfiles
    ```
2.  Navigate into the repository:
    ```sh
    cd ~/.dotfiles
    ```
3.  Use Stow to link the desired configurations. For example, to link everything:
    ```sh
    # This will symlink the contents of each folder into your home directory
    stow .
    ```
    To link a specific application's config (e.g., nvim):
    ```sh
    stow nvim
    ```
4.  Set up your Zsh configuration:
    ```sh
    cp .zshrc.example .zshrc
    # Then customize .zshrc with any local overrides
    ```

### 2. Nix & Home Manager (for NixOS systems)

The `nix-config` directory contains a complete NixOS configuration that uses flakes. This is the recommended way to achieve a fully reproducible setup.

**Prerequisites:**
*   A running NixOS system with flakes enabled.

**Steps:**

1.  Clone this repository, typically into `/etc/nixos` or a preferred location.
    ```sh
    git clone https://github.com/H-DNA/.dotfiles.git /etc/nixos
    cd /etc/nixos
    ```
2.  Build and switch to the new configuration. You may need to adjust `flake.nix` to match your hostname (`x86_64-linux` is the default).
    ```sh
    sudo nixos-rebuild switch --flake .#x86_64-linux
    ```

For more details on the NixOS setup, please refer to the detailed README in the `nix-config` directory:
[**NixOS Configuration README**](./nix-config/README.md)

---

## External dependencies

When not using the Nix-based setup, you will need to install some dependencies manually.

*   **Fonts**: `JetBrainsMono Nerd Font` is used across many of the configurations.
*   **Sway dependencies**: If using `sway`, ensure `grim` (screenshots), `swaync` (notifications), `fcitx5` (input method), and `swaybg` (wallpaper) are installed.
*   **Neovim lSPs**: The Neovim configuration uses Mason to manage LSP servers, but some may need to be installed independently depending on your environment.
