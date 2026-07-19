#--------------------------------------------------------------------------------------------------#
# Host Configuration: mediarr
#--------------------------------------------------------------------------------------------------#

{ self, inputs, config, sops-nix, nixflix, ... }: {

  flake.nixosModules.mediarr-cfg = { pkgs, lib, ... }: {
    imports = [
      #self.nixosModules.core
      #inputs.sops-nix.nixosModules.sops
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    system.stateVersion = "25.11";

    # Bootloader
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;

    # Networking #-------------------------------#
    # System-specific Network Settings
    #--------------------------------------------#

    # Enable Networking
    networking.networkmanager.enable = true;

    # Hostname
    networking.hostName = "mediarr";

    # Network Proxy
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Firewall
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # Packages #---------------------------------#
    # System-specific Packages & Settings
    #--------------------------------------------#

    # Packages (System)
    environment.systemPackages = with pkgs; [
     # ...
    ];

    # Services #---------------------------------#
    # System-specific Services
    #--------------------------------------------#

    # SSH Server
    services.openssh.enable = true;
  };
}

#--------------------------------------------------------------------------------------------------#
# End
#--------------------------------------------------------------------------------------------------#
