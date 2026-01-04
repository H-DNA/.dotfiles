# Agenix secrets configuration
#
# This file declares which secrets exist and which keys can decrypt them.
# To edit a secret: nix run github:ryantm/agenix -- -e secrets/<name>.age
# To rekey all secrets: nix run github:ryantm/agenix -- -r
#
# Public keys are used for encryption. The corresponding private keys
# (SSH keys on the target machine) are used for decryption at activation time.

let
  # User SSH keys (for editing secrets)
  huydna = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICau9YnSLqUDKy6h1ZM+0+JzaGHpVIlCbpNNtgZD+dHc";

  # Host SSH keys (for decryption at boot)
  # Get this with: ssh-keyscan localhost or cat /etc/ssh/ssh_host_ed25519_key.pub
  # For now, we use the user key for both encryption and decryption
  hell = huydna;

  # Key groups
  allUsers = [ huydna ];
  allHosts = [ hell ];
  all = allUsers ++ allHosts;
in
{
  # ZeroTier network ID
  "zerotier-network-id.age".publicKeys = all;

  # Add more secrets here as needed:
  # "database-password.age".publicKeys = all;
  # "api-key.age".publicKeys = all;
}
