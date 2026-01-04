{ pkgs, ... }:

let
  # Gruvbox color palette
  gruvboxTheme = builtins.concatStringsSep ";" [
    "border=#d79921"      # yellow border
    "text=#ebdbb2"        # light foreground
    "prompt=#fe8019"      # orange prompt
    "time=#8ec07c"        # aqua time
    "action=#fabd2f"      # bright yellow actions
    "button=#b8bb26"      # bright green buttons
    "container=#3c3836"   # dark background
    "input=#ebdbb2"       # light input text
  ];
in
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-user-session --asterisks --asterisks-char '•' --greeting 'Welcome back!' --theme '${gruvboxTheme}' --cmd sway";
        user = "greeter";
      };
    };
  };
}
