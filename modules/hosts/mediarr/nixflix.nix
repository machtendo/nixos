#--------------------------------------------------------------------------------------------------#
# Module: Nixflix
#--------------------------------------------------------------------------------------------------#

{ self, inputs, config, sops-nix, nixflix, ... }: {

  flake.nixosModules.config-nixflix = { pkgs, lib, ... }: {
    specialArgs = { inherit inputs; };
    # import any other modules here
    imports = [
      #...
    ];

    # sops-nix #---------------------------------#
    # Importing secrets
    #--------------------------------------------#

    sops.defaultSopsFile = ../../../../secrets/secrets.yaml;
    sops.defaultSopsFormat = "yaml";
    sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    sops.secrets = {
      "sonarr/api_key" = {};
      "sonarr/password" = {};
      "radarr/api_key" = {};
      "radarr/password" = {};
      "lidarr/api_key" = {};
      "lidarr/password" = {};
      "prowlarr/api_key" = {};
      "prowlarr/password" = {};
      "indexer-api-keys/DrunkenSlug" = {};
      "indexer-api-keys/NZBFinder" = {};
      "indexer-api-keys/NzbPlanet" = {};
      "jellyfin/alice_password" = {};
      "seerr/api_key" = {};
      "wireguard/conf" = {};
      "sabnzbd/api_key" = {};
      "sabnzbd/nzb_key" = {};
      "sabnzbd/username" = { };
      "sabnzbd/password" = { };
      "usenet/eweka/username" = {};
      "usenet/eweka/password" = {};
      "usenet/newsgroupdirect/username" = {};
      "usenet/newsgroupdirect/password" = {};
    };

    # Nixflix #----------------------------------#
    # Global Configuration
    #--------------------------------------------#

    nixflix = {
      enable = true;
      mediaDir = "/data/media";
      stateDir = "/data/.state";
      #mediaUsers = ["myuser"];

      # Theme Park #-----------------------------#
      # Unified Appearance
      #------------------------------------------#

      theme = {
        enable = true;
        name = "overseerr";
      };

      # Nginx #----------------------------------#
      # Reverse Proxy Server
      #------------------------------------------#

      nginx = {
        enable = true;
        addHostsEntries = true; # Disable this if you have your own DNS configuration
      };

      # PostgreSQL #-----------------------------#
      # Shared database backend
      #------------------------------------------#

      postgres.enable = true;

      # Sonarr #---------------------------------#
      # Automated Media Management (TV)
      #------------------------------------------#

      sonarr = {
        enable = true;
        config = {
          apiKey._secret = config.sops.secrets."sonarr/api_key".path;
          hostConfig.password._secret = config.sops.secrets."sonarr/password".path;
        };
      };

      # Radarr #---------------------------------#
      # Automated Media Management (Movies)
      #------------------------------------------#

      radarr = {
        enable = true;
        config = {
          apiKey._secret = config.sops.secrets."radarr/api_key".path;
          hostConfig.password._secret = config.sops.secrets."radarr/password".path;
        };
      };

      # Lidarr #---------------------------------#
      # Automated Media Management (Music)
      #------------------------------------------#

      lidarr = {
        enable = true;
        config = {
          apiKey._secret = config.sops.secrets."lidarr/api_key".path;
          hostConfig.password._secret = config.sops.secrets."lidarr/password".path;
        };
      };

      # Recyclarr #------------------------------#
      # TRaSH Optimization, Sonarr/Radarr/Lidarr
      #------------------------------------------#

      recyclarr = {
        enable = true;
        cleanupUnmanagedProfiles = true;
      };

      # Prowlarr #-------------------------------#
      # Centralized Indexer, Sonarr/Radarr/Lidarr
      #------------------------------------------#

      prowlarr = {
        enable = true;
        config = {
          apiKey._secret = config.sops.secrets."prowlarr/api_key".path;
          hostConfig.password._secret = config.sops.secrets."prowlarr/password".path;
          indexers = [

            # Usenet Indexers

            #{
            #  name = "DrunkenSlug";
            #  apiKey._secret = config.sops.secrets."indexer-api-keys/DrunkenSlug".path;
            #}

            #{
            #  name = "NZBFinder";
            #  apiKey._secret = config.sops.secrets."indexer-api-keys/NZBFinder".path;
            #}

            #{
            #  name = "NzbPlanet";
            #  apiKey._secret = config.sops.secrets."indexer-api-keys/NzbPlanet".path;
            #}

          ];
        };
      };

      # SABnzbd #--------------------------------#
      # Automation of Usenet Transfers
      #------------------------------------------#

      sabnzbd = {
        enable = false;

        settings = {
          misc = {
            api_key._secret = config.sops.secrets."sabnzbd/api_key".path;
            nzb_key._secret = config.sops.secrets."sabnzbd/nzb_key".path;
            username._secret = config.sops.secrets."sabnzbd/username".path;
            password._secret = config.sops.secrets."sabnzbd/password".path;
          };

          servers = [

            #{
            #  name = "Eweka";
            #  host = "sslreader.eweka.nl";
            #  port = 563;
            #  username._secret = config.sops.secrets."usenet/eweka/username".path;
            #  password._secret = config.sops.secrets."usenet/eweka/password".path;
            #  connections = 20;
            #  ssl = true;
            #  priority = 0;
            #  retention = 3000;
            #}

            #{
            #  name = "NewsgroupDirect";
            #  host = "news.newsgroupdirect.com";
            #  port = 563;
            #  username._secret = config.sops.secrets."usenet/newsgroupdirect/username".path;
            #  password._secret = config.sops.secrets."usenet/newsgroupdirect/password".path;
            #  connections = 10;
            #  ssl = true;
            #  priority = 1;
            #  optional = true;
            #  backup = true;
            #}

          ];
        };
      };

      # Jellyfin #-------------------------------#
      # Media Streaming Server
      #------------------------------------------#

      jellyfin = {
        enable = true;
        apiKey._secret = config.sops.secrets."jellyfin/api_key".path;
        users = {
          admin = {
            mutable = false;
            policy.isAdministrator = true;
            password._secret = config.sops.secrets."jellyfin/alice_password".path;
          };
        };
      };

      # Seerr #----------------------------------#
      # Media Request and Discovery
      #------------------------------------------#

      seerr = {
        enable = true;
        apiKey._secret = config.sops.secrets."seerr/api_key".path;
      };

      # Wireguard #------------------------------#
      # VPN Configuration
      #------------------------------------------#

      vpn = {
        enable = true;
        wgConfFile = config.sops.secrets."wireguard/conf".path;
        accessibleFrom = [ "192.168.86.0/24" ];
      };

      #------------------------------------------#
      #------------------------------------------#
      #------------------------------------------#

    };
  };
}

#--------------------------------------------------------------------------------------------------#
# End
#--------------------------------------------------------------------------------------------------#
