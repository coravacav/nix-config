{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
#    ./zsh.nix
  ];

  nixpkgs = {
    overlays = [];
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "nask";
    homeDirectory = "/home/nask";
  };

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [ 
  ];

  programs.neovim.enable = true;
  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.zoxide = { enable = true; enableZshIntegration = true; };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.ssh = {
    enable = true;
    compression = true;
    forwardAgent = true;
    extraConfig = "AddKeysToAgent yes";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
