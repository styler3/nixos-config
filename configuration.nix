{ config, pkgs, ... }:

{
  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  # Set up Networking
  networking.hostName = "faramir";
  networking.networkmanager.enable = true;

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s25.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  # Set your time zone.
  time.timeZone = "Australia/Adelaide";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    vlc
    neovim
    firefox
    thunderbird
    git
    git-bug
    hexchat
    w3m
    screenfetch
    bc
    peek
    pandoc
    texlive.combined.scheme-medium
    okular
    mullvad-vpn
    clementine
    ungoogled-chromium
    neovide
  ];

  # VPN
  networking.iproute2.enable = true;
  services.mullvad-vpn.enable = true;

  # List services that you want to enable:
  services.openssh.enable = true; # ssh
  services.openssh.passwordAuthentication = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Set up XFCE
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };

    displayManager.defaultSession = "xfce";
  };
  services.picom = {
    enable = true;
    fade = true;
    inactiveOpacity = 0.9;
    shadow = true;
    fadeDelta = 4;
  };

  # Install fonts
  fonts.fonts = with pkgs; [
    source-code-pro
    source-sans-pro
    source-serif-pro
    hasklig
  ];
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sam = {
    isNormalUser = true;
    description = "Sam Tyler";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.bash;
  };

  # Set up aliases, etc.
  environment.interactiveShellInit = ''
    EDITOR=nvim
    BROWSER=firefox
    alias vi='nvim'
    alias nvi='neovide'
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03";

}

