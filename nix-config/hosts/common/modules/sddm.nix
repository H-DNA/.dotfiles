{ pkgs, ... }:

let
  # Gruvbox-themed sddm-astronaut
  sddm-astronaut-gruvbox = pkgs.sddm-astronaut.override {
    themeConfig = {
      # Background - use sway wallpaper
      Background = "/home/huydna/.config/sway/nixdog/background/default.jpg";
      DimBackgroundImage = "0.3";

      # Gruvbox dark color scheme
      FullBlur = "true";
      BlurRadius = "80";
      FormPosition = "center";

      # Colors - Gruvbox palette
      BackgroundColor = "#1d2021";
      MainColor = "#ebdbb2";
      AccentColor = "#d79921";
      PlaceholderColor = "#928374";
      IconColor = "#ebdbb2";
      HoverColor = "#458588";
      HoverTextColor = "#1d2021";

      # Font
      Font = "JetBrainsMono Nerd Font";
      FontSize = "12";

      # Interface
      HaveFormBackground = "true";
      FormBackgroundColor = "#282828";
      PartialBlur = "true";

      # Behavior
      ForceHideCompletePassword = "true";
    };
  };
in
{
  services.displayManager = {
    sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm;
      wayland.enable = true;
      theme = "sddm-astronaut-theme";
      extraPackages = [ sddm-astronaut-gruvbox ];
    };
    defaultSession = "sway";
  };

  environment.systemPackages = [ sddm-astronaut-gruvbox ];
}
