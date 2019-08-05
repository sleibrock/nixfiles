# The Stove NixOS configuration file

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Set Grub2 loader with UEFI
  # TODO: split this between different host device configs
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  # boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only
  boot.loader.grub.device = "nodev";

  # Network hostname and wifi
  # TODO: split this between different devices
  networking.hostName = "stove-desktop";
  networking.wireless.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Font for internationalisation
  i18n = {
    consoleFont = "Fira Code";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    tewi-font
    (nerdfonts.override {
      withFont = "--complete FiraCode";
    })
  ];

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Enable non-free packages
  nixpkgs.config.allowUnfree = true;

  # Enable broken packages
  # Should be removed as soon as possible
  # or limited to the scope of purely Steam
  # nixpkgs.config.allowBroken = true;

  # Enable 32-bit support (required for Steam)
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # desktop stuffs
    firefox
    keybase
    keybase-gui
    kbfs
    alacritty
    blender
    dmenu
    arc-theme
    transmission-gtk

    # utilities
    curl
    wget 
    vim
    emacs
    git
    htop
    zsh
    arandr
    xclip
    scrot
    screenfetch
    feh
    zip
    unzip
    ffmpeg
    pcmanfm
    #xev

    # programming
    gcc      # c/c++
    gnumake  # make
    rustup   # rustc/cargo
    ghc      # haskell
    python
    ruby
    #go #where is golang?
    racket
    guile
    #common-lisp #where is common lisp?
    fsharp   # F#
    #csharp # where is C#?
    ocaml
    arduino  # Arduino IDE
    elixir
    
    # audio / media production
    obs-studio
    pavucontrol
    pulseaudio-ctl
    picard
    mp3gain
    sonic-pi
    supercollider
    puredata
    jack2
    qjackctl

    # fun
    openttd
    runelite
    steam
    gzdoom

    # experimental for steam native libs
    # broken; don't touch
    #(steam.override { extraPkgs = pkgs: [ mono gtk3 gtk3-x11 libgdiplus zlib libffi pcre ]; nativeOnly = true; })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # enable Keybase
  services.keybase.enable = true;
  services.kbfs.enable = true;

  # Open ports in the firewall.
  # Configure this for game servers if need be
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Configure our xserver with sddm/i3-wm 
  services.xserver.displayManager.sddm.enable = true;
#  services.xserver.windowManager.i3.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  # Docker/Flatpak stuff

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.steve = {
     uid = 1000;
     description = "Steven Leibrock";
     shell = pkgs.zsh;
     isNormalUser = true;
     extraGroups = [ "wheel" "audio" "video" "lock" "uucp" "docker" ]; # Enable ‘sudo’ for the user.
  };


  # enable ADB
  programs.adb.enable = true;

  # NixOS system version, only update when NixOS tells you to
  system.stateVersion = "19.03";

}
