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

  # Zsh configuration (user-level)
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -la";
      la = "ls -A";
      l = "ls -CF";
      ".." = "cd ..";
      "..." = "cd ../..";
      g = "git";
      gs = "git status";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";
      gd = "git diff";
      ga = "git add";
      gco = "git checkout";
      gb = "git branch";
      vim = "nvim";
      v = "nvim";
    };

    initContent = ''
      # Initialize zoxide
      eval "$(zoxide init zsh)"

      # Initialize fzf
      if [ -n "$(command -v fzf)" ]; then
        source <(fzf --zsh)
      fi
    '';
  };

  # Starship prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
