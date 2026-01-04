{ pkgs, ... }:

{

  # Shell aliases for manual reloading
  programs.zsh.shellAliases = {
    # Nix/NixOS
    rebuild = "sudo nixos-rebuild switch --flake ~/nix-config";
    rebuild-test = "sudo nixos-rebuild test --flake ~/nix-config";
    nix-gc = "nix-collect-garbage -d && sudo nix-collect-garbage -d";
    nix-gc-old = "sudo nix-env --delete-generations old --profile /nix/var/nix/profiles/system && sudo nix-collect-garbage -d";

    # Tmux
    reload-tmux = "tmux source-file ~/.tmux.conf && echo 'tmux config reloaded'";

    # Sway
    reload-sway = "swaymsg reload";

    # Waybar (via systemd)
    reload-waybar = "systemctl --user restart waybar";
    waybar-logs = "journalctl --user -u waybar -f";
  };
}
