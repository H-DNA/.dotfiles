{ pkgs, ... }:

{
  # Window system
  programs.sway.enable = true;
  xdg.portal.wlr.enable = true;

  environment.systemPackages = with pkgs; [
    swaylock-effects
    swayidle
    swww
    wofi
    grim
    brightnessctl
    waybar
    swaynotificationcenter
  ];

  # No need if enable wayland but just add it here
  services.libinput.enable = true;
}
