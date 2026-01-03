# Dotfiles

This repository contains my personal dotfiles and configurations for various tools, primarily for a Linux environment running a Wayland compositor.

The configurations are managed in two ways:
1.  **Stow**: For simple, standalone configurations that can be symlinked directly into the home directory.
2.  **Nix & Home Manager**: For a more declarative and reproducible setup, especially for system-level configurations and managing packages. The Nix configuration is located in the `nix-config` directory.

## Managed Applications

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

## External Dependencies

When not using the Nix-based setup, you will need to install some dependencies manually.

*   **Fonts**: `JetBrainsMono Nerd Font` is used across many of the configurations.
*   **Sway Dependencies**: If using `sway`, ensure `grim` (screenshots), `swaync` (notifications), `fcitx5` (input method), and `swaybg` (wallpaper) are installed.
*   **Neovim LSPs**: The Neovim configuration uses Mason to manage LSP servers, but some may need to be installed independently depending on your environment.