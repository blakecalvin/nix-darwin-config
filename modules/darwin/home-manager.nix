{ config, pkgs, lib, home-manager, ... }:

let
  user = "blakecalvin";
  # Define the content of your file as a derivation
  #myEmacsLauncher = pkgs.writeScript "emacs-launcher.command" ''
  #  #!/bin/sh
  #  emacsclient -c -n &
  #'';
  sharedFiles = import ../shared/files.nix { inherit config pkgs; };
  additionalFiles = import ./files.nix { inherit user config pkgs; };
in
{
  imports = [
   ./dock
  ];

  # It me
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = true;
    casks = pkgs.callPackage ./casks.nix {};
    brews = pkgs.callPackage ./brews.nix {};
    # onActivation.cleanup = "uninstall";

    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    # If you have previously added these apps to your Mac App Store profile (but not installed them on this system),
    # you may receive an error message "Redownload Unavailable with This Apple ID".
    # This message is safe to ignore. (https://github.com/dustinlyons/nixos-config/issues/83)
    masApps = {
      # waiting on bug fix for mas for this to work https://github.com/mas-cli/mas/pull/535
      #"Hyperduck" = 2145267525;
      "Affinity Designer 2" = 1616831348;
      "Affinity Publisher 2" = 1606941598;
      "Affinity Photo 2" = 1616822987;
      "Darkroom" = 953286746;
      "Hidden Bar" = 1452453066;
      "Bitwarden" = 1352778147;
      "Xcode" = 497799835;
    };
  };

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    users.${user} = { pkgs, config, lib, ... }:{
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = pkgs.callPackage ./packages.nix {};
        file = lib.mkMerge [
          sharedFiles
          additionalFiles
	  # Use this to add additional
          #{ "emacs-launcher.command".source = myEmacsLauncher; }
        ];
        stateVersion = "23.11";
      };
      programs = {} // import ../shared/home-manager.nix { inherit config pkgs lib; };

      # Marked broken Oct 20, 2022 check later to remove this
      # https://github.com/nix-community/home-manager/issues/3344
      manual.manpages.enable = false;
    };
  };

  # Fully declarative dock using the latest from Nix Store
  local.dock.enable = true;
  local.dock.entries = [
    { path = "/Applications/Launchpad.app/"; }
    { path = "/Applications/Arc.app/"; }
    { path = "/Applications/Zed.app/"; }
    { path = "/Applications/iTerm.app/"; }
    # Use this format for Nixpkgs
    # { path = "${pkgs.alacritty}/Applications/Alacritty.app/"; }
    { path = "/System/Applications/Notes.app/"; }
    { path = "/System/Applications/Messages.app/"; }
    # Enable later when I update my phone OS
    # { path = "/System/Applications/iPhone Mirroring.app/"; }
    {
      path = "${config.users.users.${user}.home}/Downloads";
      section = "others";
      options = "--sort name --view grid --display stack";
    }
  ];

}
