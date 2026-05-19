#---------------------------------------------------------------------------------------------------
# Host Configuration: mediarr
#---------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {

  flake.nixosModules.mediarrConfiguration = { pkgs, lib, ... }: {
    # Import Modules
    imports = [
    ];

    # Enable Flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Bootloader.
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;

    networking.hostName = "mediarr"; # Define your hostname.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networking.networkmanager.enable = true;

    # List packages installed in system profile. To search, run:
    environment.systemPackages = with pkgs; [
      neovim        # Neovim - Text Editor
      wget
      git
    ];

    # List services that you want to enable:
    services.openssh.enable = true;     # OpenSSH Server

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    system.stateVersion = "25.11";
  };
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
