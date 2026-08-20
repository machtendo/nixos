#--------------------------------------------------------------------------------------------------
# Module Configuration: nginx
#--------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {

  flake.nixosModules.searxng = { pkgs, lib, config, ... }: {
    imports = [
      # ...
    ];

    # Systemd Configuration
    systemd.services.nginx.serviceConfig.ProtectHome = false;

    # User Management
    users.groups.searx.members = ["nginx"];

    # Nginx Configuration
    services.nginx = {
      enable = true;
      recommendedGzipSettings     = true;
      recommendedOptimisation     = true;
      recommendedProxySettings    = true;
      recommendedTlsSettings      = true;

      virtualHosts = {
        "search.example.com" = {
          forceSSL                = true;
          sslCertificate          = "...";
          sslCertificateKey       = "...";

          locations = {
            "/" = {
              extraConfig = ''
                uwsgi_pass unix:${config.services.searx.uwsgiConfig.socket};
              '';
            };
          };
        };
      };
    };
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
