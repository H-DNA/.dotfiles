{ default-username, pkgs, ... }:

{
  # User packages are now managed by Home Manager
  # See: /home/<username>/packages.nix
  #
  # This file only contains host-specific user configuration
  # that cannot be managed by Home Manager (e.g., docker group membership)

  users.users.${default-username} = {
    extraGroups = [ "docker" ];
  };
}
