#---------------------------------------------------------------------------------------------------
# Host Configuration: armvm
#---------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {

  flake.nixosConfigurations.armvm = inputs.nixpkgs.lib.nixosSystem {
    system = "aarch64-linux";
    modules = with self.nixosModules; [
      armvm         # Configuration - Host: armvm
    ];
  };

  flake.nixosModules.armvm = { pkgs, lib, ... }: {
    imports = [
      #armvm-hw      # Configuration - Hardware: armvm
      self.nixosModules.user-nix      # Configuration - User: nix
      self.nixosModules.core          # Configuration - Core: All Devices
    ];

    # Flakes  ------------------------------------
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Boot ---------------------------------------

    #boot.kernelParams = [ "reboot=acpi" ];

    # Bootloader ---------------------------------
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;

    # Networking ---------------------------------

    # Enable Networking
    networking.networkmanager.enable = true;

    # Hostname
    networking.hostName = "armvm";

    # Network Proxy
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Firewall
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # Packages  ----------------------------------

    # System
    environment.systemPackages = with pkgs; [
     # ...
    ];

    # Services -----------------------------------

    services.openssh.enable = true;     # OpenSSH Server

    # System State Version -----------------------
    system.stateVersion = "26.05";

    #--------------------------------------------#
    #--------------------------------------------#
    #--------------------------------------------#

  };
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
