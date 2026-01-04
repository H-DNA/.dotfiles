{ pkgs, ... }:

{
  # Window system
  programs.sway.enable = true;
  xdg.portal.wlr.enable = true;

  # Cursor theme (fixes disappearing cursor in some web apps)
  environment.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
  };

  environment.systemPackages = with pkgs; [
    # Cursor theme
    bibata-cursors

    # Sway core
    swaylock-effects
    swayidle
    swww
    wofi

    # Screenshot
    grim
    slurp
    wl-clipboard

    # System controls
    brightnessctl
    pavucontrol
    pwvucontrol
    blueman
    networkmanagerapplet

    # Bar & notifications
    waybar
    swaynotificationcenter
  ];

  # No need if enable wayland but just add it here
  services.libinput.enable = true;
}
