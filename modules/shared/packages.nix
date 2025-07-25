{ pkgs }:

with pkgs; [
  # General packages for development and system management
  #alacritty
  #aspell
  #aspellDicts.en
  #bash-completion
  #bat
  #btop
  coreutils
  killall
  #neofetch
  openssh
  #sqlite
  wget
  # tailscale
  gh
  gitui
  #zip

  cargo
  rustc

  # Encryption and security tools
  #age
  #age-plugin-yubikey
  #gnupg
  #libfido2

  # Media-related packages
  #emacs-all-the-icons-fonts
  #dejavu_fonts
  #ffmpeg
  #fd
  #font-awesome
  #hack-font
  #noto-fonts
  #noto-fonts-emoji
  #meslo-lgs-nf

  # Node.js development tools
  #nodePackages.npm # globally install npm
  #nodePackages.prettier
  #nodejs

  # Text and terminal utilities
  #htop
  #hunspell
  #iftop
  jetbrains-mono
  #jq
  #ripper
  #tree
  tmux
  #unrar
  #unzip
  #zsh-powerlevel10k
  #gemini-cli
  claude-code
]
