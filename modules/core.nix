#--------------------------------------------------------------------------------------------------#
# Modular Configuration: Core System - All Devices
#--------------------------------------------------------------------------------------------------#

{ self, inputs, ... }: {

  flake.nixosModules.core = { pkgs, lib, ... }: {
    # import any other modules here
    imports = [
      /etc/nixos/hardware-configuration.nix
      # ...
    ];

    # Enable Flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Keyboard Settings
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    # Time Zone
    time.timeZone = "America/Chicago";

    # Locale
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    # Optimization #-----------------------------#
    # Optimize Nix-Store During Rebuilds
    #--------------------------------------------#

    nix.settings.auto-optimise-store = true;

    # Purge Unused Nix-Store Entries
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    # Packages #---------------------------------#
    # Baseline packages for all devices
    #--------------------------------------------#

    nixpkgs.config.allowUnfree = true;

    # Packages (System)
    environment.systemPackages = with pkgs; [
      btop          # Process Manager TUI
      wget          # File Downloader - HTTP, HTTPS, FTP and FTPS
      git           # Git - Version Control
      neovim        # Neovim - Text Editor
      sops          # Secrets Management
      age           # File Encryption
      tree          # Directory Listing TUI
    ];

    # Environment #------------------------------#
    # Environment Variables
    #--------------------------------------------#

    environment.variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    #--------------------------------------------#
    #--------------------------------------------#
    #--------------------------------------------#

  };
}

#--------------------------------------------------------------------------------------------------#
# End
#--------------------------------------------------------------------------------------------------#
