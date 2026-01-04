{ pkgs, ... }:

{
  # File Browser - web-based file manager
  # Secret baseURL generated at first boot (not in git)

  # Generate secret on first boot
  system.activationScripts.filebrowserSecret = ''
    SECRET_FILE="/var/lib/filebrowser/secret"
    if [ ! -f "$SECRET_FILE" ]; then
      mkdir -p /var/lib/filebrowser
      ${pkgs.openssl}/bin/openssl rand -hex 8 > "$SECRET_FILE"
    fi
    chmod 644 "$SECRET_FILE"  # Readable by user for script
  '';

  services.filebrowser = {
    enable = true;
    settings = {
      address = "127.0.0.1";
      port = 41819;
      root = "/home/huydna";
      database = "/var/lib/filebrowser/filebrowser.db";
      auth.method = "noauth";
      commands = [];
    };
  };

  # Override service to use runtime secret and run as user
  systemd.services.filebrowser.serviceConfig = {
    User = pkgs.lib.mkForce "huydna";
    Group = pkgs.lib.mkForce "users";
    WorkingDirectory = pkgs.lib.mkForce "/home/huydna";
    ExecStart = pkgs.lib.mkForce (
      pkgs.writeShellScript "filebrowser-start" ''
        SECRET=$(cat /var/lib/filebrowser/secret)
        exec ${pkgs.filebrowser}/bin/filebrowser \
          --address 127.0.0.1 \
          --port 41819 \
          --root /home/huydna \
          --database /var/lib/filebrowser/filebrowser.db \
          --baseurl "/$SECRET" \
          --noauth
      ''
    );
  };
}
