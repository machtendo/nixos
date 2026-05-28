#---------------------------------------------------------------------------------------------------
# Modular Configuration: Base System
#---------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {

  flake.nixosModules.config-base = { pkgs, lib, ... }: {
    # import any other modules here
    imports = [
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

    # Optimization ---------------------------------

    # Optimize Nix-Store During Rebuilds
    nix.settings.auto-optimise-store = true;

    # Purge Unused Nix-Store Entries
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    # Packages -----------------------------------

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Packages (System)
    environment.systemPackages = with pkgs; [
      neovim        # Neovim - Text Editor
      wget
      git
    ];
  };
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
