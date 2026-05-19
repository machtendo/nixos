#---------------------------------------------------------------------------------------------------
# Host Configuration: mediarr
#---------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {

  flake.nixosModules.mediarrConfiguration = { pkgs, lib, ... }: {
    # import any other modules here
    imports = [
      self.nixosModules.mediarrHardware
    ];

    # Enable Flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Bootloader.
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;

    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    # Set your time zone.
    # time.timeZone = "America/Chicago";
    #
    # Select internationalisation properties.
    # i18n.defaultLocale = "en_US.UTF-8";
    #
    # i18n.extraLocaleSettings = {
    #   LC_ADDRESS = "en_US.UTF-8";
    #   LC_IDENTIFICATION = "en_US.UTF-8";
    #   LC_MEASUREMENT = "en_US.UTF-8";
    #   LC_MONETARY = "en_US.UTF-8";
    #   LC_NAME = "en_US.UTF-8";
    #   LC_NUMERIC = "en_US.UTF-8";
    #   LC_PAPER = "en_US.UTF-8";
    #   LC_TELEPHONE = "en_US.UTF-8";
    #   LC_TIME = "en_US.UTF-8";
    # };
    #
    # Configure keymap in X11
    # services.xserver.xkb = {
    #   layout = "us";
    #   variant = "";
    # };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.nix = {
      isNormalUser = true;
      description = "nix";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [];
    };

    # Allow unfree packages
    #nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      neovim        # Neovim - Text Editor
      wget
      git
    ];

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    system.stateVersion = "25.11";
  };
}
