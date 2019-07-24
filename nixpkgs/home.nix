{ pkgs, ... }:

{
  #programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;


  home.packages = with pkgs; [
    # trains, buses, planes, boats
    openttd

    # desktop apps 
    firefox
    gimp
    blender
    vlc
    mpv
    pcmanfm
    youtube-dl

    # programming
    git
    emacs
    python
    ruby
    ghc
    cabal-install
    arduino
    racket
    rustup
    go
    vim
    feh
    scrot
    xclip
    pavucontrol
    arandr

    # games
    steam

    # etc
    obs-studio
    transmission-gtk
  ];

  programs.home-manager = {
    enable = true;
    path = "...";
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.theme-vertex;
      name = "Vertex-Dark";
    };
    iconTheme = {
      package = pkgs.tango-icon-theme;
      name = "Tango";
    };
  };


  # configuration files
  
  home.file.".gitconfig".source = config/.gitconfig;

  # link to a mutable file by inclusion
  home.file.".emacs.d/init.el".text = ''
    (setq custom-file "${toString config/custom.el}")
    (load custom-file)
  '';

}
