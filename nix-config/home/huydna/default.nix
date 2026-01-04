{ pkgs, default-username, ... }:

{
  imports = [
    ./packages.nix
    ./services.nix
  ];

  home = {
    username = default-username;
    homeDirectory = "/home/${default-username}";
    stateVersion = "25.05";
  };

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # Git configuration (user-level)
  programs.git = {
    enable = true;
    settings = {
      user.name = "Huy Do";
      user.email = "huydo862003@gmail.com";
      init.defaultBranch = "master";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };

  # Zsh configuration - all config managed in dotfiles/.zshrc.example
  programs.zsh = {
    enable = true;
    enableCompletion = false;
    autosuggestion.enable = false;
    syntaxHighlighting.enable = false;
    initContent = builtins.readFile ../../../.zshrc.example;
  };
}
