#---------------------------------------------------------------------------------------------------
# Module: Nixflix
#---------------------------------------------------------------------------------------------------

{ self, inputs, ... }: {

  flake.nixosModules.nixflix = { pkgs, lib, config, ... }:

  let
    inherit (inputs.nixflix.lib.jellyfinPlugins) fromRepo;
    qbCfg = config.nixflix.torrentClients.qbittorrent;
  in

  {
    imports = [
      inputs.nixflix.nixosModules.default
      # ...
    ];


    # sops-nix -----------------------------------
    # Importing secrets
    #---------------------------------------------

    sops = {
      defaultSopsFile           = ../../secrets/nixflix.yaml;
      defaultSopsFormat         = "yaml";

      age = {
        keyFile                 = "/home/nix/.config/sops/age/keys.txt";
        sshKeyPaths             = [ "/etc/ssh/ssh_host_ed25519_key" ];
      };

      secrets = {
        "sonarr/api_key"                  = {};
        "sonarr/password"                 = {};
        "radarr/api_key"                  = {};
        "radarr/password"                 = {};
        "lidarr/api_key"                  = {};
        "lidarr/password"                 = {};
        "prowlarr/api_key"                = {};
        "prowlarr/password"               = {};
        "indexer-api-keys/DrunkenSlug"    = {};
        "indexer-api-keys/NZBFinder"      = {};
        "indexer-api-keys/NzbPlanet"      = {};
        "jellyfin/alice_password"         = {};
        "jellyfin/api_key"                = {};
        "seerr/api_key"                   = {};
        "wireguard/conf"                  = {};
        "sabnzbd/api_key"                 = {};
        "sabnzbd/nzb_key"                 = {};
        "sabnzbd/username"                = {};
        "sabnzbd/password"                = {};
        "qbittorrent/password"            = {};
        "usenet/eweka/username"           = {};
        "usenet/eweka/password"           = {};
        "usenet/newsgroupdirect/username" = {};
        "usenet/newsgroupdirect/password" = {};
        "navidrome/password"              = {};
        "opensubtitles/api-key"           = {};
        "opensubtitles/username"          = {};
        "opensubtitles/password"          = {};
      };
    };

    # ACME ------------------------------------
    # Let's Encrpyt SSL
    #---------------------------------------------

    #security = {
    #  acme = {
    #    acceptTerms = true;
    #    certs = {
    #      nixflix = "";
    #    };
    #  };
    #};

    # Nixflix ------------------------------------
    # Global Configuration
    #---------------------------------------------

    nixflix = {
      enable                    = true;
      mediaDir                  = "/data/media";
      stateDir                  = "/data/.state";
      mediaUsers                = ["nixflix"];

      # Theme ------------------------------------
      # Unified Appearance (Theme Park)
      #-------------------------------------------

      theme = {
        enable                  = true;
        name                    = "overseerr";
      };

      # Wireguard --------------------------------
      # VPN Configuration
      #-------------------------------------------

      vpn = {
        enable                = true;
        wgConfFile            = config.sops.secrets."wireguard/conf".path;
        #accessibleFrom       = [ "192.168.1.0/24" ];
      };

      # Nginx ------------------------------------
      # Reverse Proxy Server
      #-------------------------------------------

      nginx = {
        enable                  = true;
        addHostsEntries         = true; # Disable this if you have your own DNS configuration
        #inherit (config.system.ddns) domain;
        #forceSSL                = true;
        #enableACME              = true;
      };

      # PostgreSQL -------------------------------
      # Shared database backend
      #-------------------------------------------

      postgres = {
        enable                  = true;
      };

      # Recyclarr --------------------------------
      # TRaSH Optimization, Sonarr/Radarr/Lidarr
      #-------------------------------------------

      recyclarr = {
        enable                  = true;
        cleanupUnmanagedProfiles = {
          enable                = true;
        };
      };

      # Sonarr -----------------------------------
      # Automated Media Management (TV)
      #-------------------------------------------

      sonarr = {
        enable                  = true;
        subdomain               = "tv";
        config = {
          apiKey = {
            _secret             = config.sops.secrets."sonarr/api_key".path;
          };
          hostConfig = {
            password = {
              _secret           = config.sops.secrets."sonarr/password".path;
            };
          };
          delayProfiles = [
            {
              enableUsenet                    = false;
              enableTorrent                   = true;
              preferredProtocol               = "torrent";
              usenetDelay                     = 0;
              torrentDelay                    = 0;
              bypassIfHighestQuality          = true;
              bypassIfAboveCustomFormatScore  = false;
              minimumCustomFormatScore        = 0;
              order                           = 2147483647;
              tags                            = [];
              id                              = 1;
            }
          ];
        };
      };

      # Radarr -----------------------------------
      # Automated Media Management (Movies)
      #-------------------------------------------

      radarr = {
        enable                  = true;
        subdomain               = "movies";
        config = {
          apiKey = {
            _secret             = config.sops.secrets."radarr/api_key".path;
          };
          hostConfig = {
            password = {
              _secret           = config.sops.secrets."radarr/password".path;
            };
          };
          delayProfiles = [
            {
              enableUsenet                    = false;
              enableTorrent                   = true;
              preferredProtocol               = "torrent";
              usenetDelay                     = 0;
              torrentDelay                    = 0;
              bypassIfHighestQuality          = true;
              bypassIfAboveCustomFormatScore  = false;
              minimumCustomFormatScore        = 0;
              order                           = 2147483647;
              tags                            = [];
              id                              = 1;
            }
          ];
        };
      };

      # Lidarr -----------------------------------
      # Automated Media Management (Music)
      #-------------------------------------------

      lidarr = {
        enable                  = true;
        subdomain               = "music";
        config = {
          apiKey = {
            _secret             = config.sops.secrets."lidarr/api_key".path;
          };
          hostConfig = {
            password = {
              _secret           = config.sops.secrets."lidarr/password".path;
            };
          };
          delayProfiles = [
            {
              enableUsenet = false;
              enableTorrent = true;
              preferredProtocol = "torrent";
              usenetDelay = 0;
              torrentDelay = 0;
              bypassIfHighestQuality = true;
              bypassIfAboveCustomFormatScore = false;
              minimumCustomFormatScore = 0;
              order = 2147483647;
              tags = [ ];
              id = 1;
            }
          ];
        };
      };

      # Prowlarr ---------------------------------
      # Centralized Indexer, Sonarr/Radarr/Lidarr
      #-------------------------------------------

      prowlarr = {
        enable                  = true;
        subdomain               = "index";
        config = {
          apiKey = {
            _secret             = config.sops.secrets."prowlarr/api_key".path;
          };
          hostConfig = {
            password = {
              _secret           = config.sops.secrets."prowlarr/password".path;
            };
          };
          indexers = [

            # Usenet Indexers --------------------

            # DrunkenSlug
            {
             enable = false;
             name = "DrunkenSlug";
             apiKey = {
               _secret        = config.sops.secrets."indexer-api-keys/DrunkenSlug".path;
             };
            }

            # NZBFinder
            {
             enable = false;
             name = "NZBFinder";
             apiKey = {
               _secret         = config.sops.secrets."indexer-api-keys/NZBFinder".path;
             };
            }

            #NzbPlanet
            {
             enable = false;
             name = "NzbPlanet";
             apiKey = {
               _secret        = config.sops.secrets."indexer-api-keys/NzbPlanet".path;
             };
            }

            # Torrent Indexers -------------------

            # Example Torrent
            #{
            # enable = true;
            # name = "";
            # baseUrl = "";
            # radarr_compatibility = true;
            # sonarr_compatibility = true;
            #}
          ];
        };
      };

      # Qbittorrent ------------------------------
      # Bittorrent Client
      #-------------------------------------------

      torrentClients = {
        qbittorrent = {
          enable = true;
          subdomain = "torrent";
          password = {
            _secret = config.sops.secrets."qbittorrent/password".path;
          };
          serverConfig = {
            LegalNotice = {
              Accepted = true;
            };
            BitTorrent = {
                Session = {
                  AddTorrentStopped = false;
                  Port = 45500;
                  QueueingSystemEnabled = true;
                  SSL = {
                    Port = 32380;
                  };
                  ReannounceWhenAddressChanged = true;
                };
            };
            Preferences = {
              WebUI = {
                Username = "torrent";
                Password_PBKDF2 = "";
              };
              General = {
                Locale = "en";
              };
            };
          };
        };
      };

      # SABnzbd ----------------------------------
      # Automation of Usenet Transfers
      #-------------------------------------------

      usenetClients = {
        sabnzbd = {
          enable                  = false;
          subdomain               = "nzb";
          settings = {
            misc = {
              api_key = {
                _secret           = config.sops.secrets."sabnzbd/api_key".path;
              };
              nzb_key = {
                _secret           = config.sops.secrets."sabnzbd/nzb_key".path;
              };
              username = {
                _secret           = config.sops.secrets."sabnzbd/username".path;
              };
              password = {
                _secret           = config.sops.secrets."sabnzbd/password".path;
              };

            };

          servers = [
          #
          #   {
          #    name               = "Eweka";
          #    host               = "sslreader.eweka.nl";
          #    port               = 563;
          #    username._secret   = config.sops.secrets."usenet/eweka/username".path;
          #    password._secret   = config.sops.secrets."usenet/eweka/password".path;
          #    connections        = 20;
          #    ssl                = true;
          #    priority           = 0;
          #   }
          #
          #   {
          #    name               = "NewsgroupDirect";
          #    host               = "news.newsgroupdirect.com";
          #    port               = 563;
          #    username._secret   = config.sops.secrets."usenet/newsgroupdirect/username".path;
          #    password._secret   = config.sops.secrets."usenet/newsgroupdirect/password".path;
          #    connections        = 10;
          #    ssl                = true;
          #    priority           = 1;
          #    optional           = true;
          #    backup             = true;
          #   }
            ];
          };
        };
      };

      # Jellyfin ---------------------------------
      # Media Streaming Server
      #-------------------------------------------

      jellyfin = {
        enable                = true;
        subdomain             = "watch";
        apiKey = {
          _secret             = config.sops.secrets."jellyfin/api_key".path;
        };
        network = {
          enableRemoteAccess  = true;
        };
        branding = {
          customCss = ''
            @import url("https://theme-park.dev/css/base/jellyfin/${config.nixflix.theme.name}.css");
          '';
        };
        users = {
          admin = {
            mutable           = false;
            policy = {
              isAdministrator = true;
            };
            password = {
              _secret         = config.sops.secrets."jellyfin/alice_password".path;
            };
          };
        };
        libraries =

          let
            subtitleSettings = {
              subtitleDownloadLanguages = [
                "eng"
              ];
              requirePerfectSubtitleMatch = true;
            };
          in

          {
          #Anime                         = subtitleSettings;
          #Music                         = lib.mkForce null;

          Movies      = subtitleSettings // {
            collectionType                = "movies";
            enableRealtimeMonitor         = true;
            metadataCountryCode           = "US";
            preferredMetadataLanguage     = "en";
            paths = [
              "/mnt/movies"
            ];
          };
          Television  = subtitleSettings // {
            collectionType                = "tvshows";
            enableRealtimeMonitor         = true;
            metadataCountryCode           = "US";
            preferredMetadataLanguage     = "en";
            seasonZeroDisplayName         = "Specials";
            paths = [
              "/mnt/tv"
            ];
          };
        };

        plugins = {
          subbuzz = {
            enable                        = true;
            config = {
              OpenSubApiKey = {
                _secret                   = config.sops.secrets."opensubtitles/api-key".path;
              };
              OpenSubUserName =           = "username";
              OpenSubPassword = {
                _secret                   = config.sops.secrets."opensubtitles/password".path;
              };
              EnableOpenSubtitles         = true;
              EnableYifySubtitles         = true;
              Cache = {
                SubLifeInMinutes          = "Always";
              };
            };
          };
          "Subtitle Extract" = {
            enable                        = true;
            config = {
              ExtractionDuringLibraryScan = true;
            };
          };
          "Intro Skipper" = {
            package = fromRepo {
              version                     = "1.10.11.17";
              hash                        = "sha256-cfEnLqKeEGpQSth3NPjDnxCkgv2pePfgCXfVIOrYSiQ=";
            };
            config = {
              ExcludeSeries                       = "";
              AutoDetectIntros                    = true;
              AnalyzeSeasonZero                   = false;
              PreferChromaprint                   = false;
              CacheFingerprints                   = true;
              UseAlternativeBlackFrameAnalyzer    = false;
              UpdateMediaSegments                 = true;
              RebuildMediaSegments                = true;
              ScanIntroduction                    = true;
              ScanCredits                         = true;
              ScanRecap                           = true;
              ScanPreview                         = true;
              ScanCommercial                      = false;
              AnalysisPercent                     = "25";
              AnalysisLengthLimit                 = "10";
              FullLengthChapters                  = false;
              SkipFirstEpisode                    = false;
              SkipFirstEpisodeAnime               = false;
              MinimumIntroDuration                = "15";
              MaximumIntroDuration                = "120";
              MinimumCreditsDuration              = "15";
              MaximumCreditsDuration              = "450";
              MaximumMovieCreditsDuration         = "900";
              MinimumRecapDuration                = "15";
              MaximumRecapDuration                = "120";
              MinimumPreviewDuration              = "15";
              MaximumPreviewDuration              = "120";
              MinimumCommercialDuration           = "15";
              MaximumCommercialDuration           = "120";
              BlackFrameMinimumPercentage         = "85";
              BlackFrameThreshold                 = "28";
              UseChapterMarkersBlackFrame         = true;
              AdjustIntroBasedOnChapters          = true;
              AdjustIntroBasedOnSilence           = true;
              SnapToKeyframe                      = true;
              EndSnapThreshold                    = "2";
              AdjustWindowInward                  = "5";
              AdjustWindowOutward                 = "2";
              ChapterAnalyzerIntroductionPattern  = "(^|\\s)(Intro|Introduction|OP|Opening)(?!\\sEnd)(\\s|$)";
              ChapterAnalyzerEndCreditsPattern    = "(^|\\s)(Credits?|ED|Ending|Outro)(?!\\sEnd)(\\s|$)";
              ChapterAnalyzerPreviewPattern       = "(^|\\s)(Preview|PV|Sneak\\s?Peek|Coming\\s?(Up|Soon)|Next\\s+(time|on|episode)|Extra|Teaser|Trailer)(?!\\sEnd)(\\s|:|$)";
              ChapterAnalyzerRecapPattern         = "(^|\\s)(Re?cap|Sum{1,2}ary|Prev(ious(ly)?)?|(Last|Earlier)(\\s\\w+)?|Catch[ -]up)(?!\\sEnd)(\\s|:|$)";
              ChapterAnalyzerCommercialPattern    = "(^|\\s)(Ad(vert(isement)?)?|Commercial)(?!\\sEnd)(\\s|$)";
              IntroEndOffset                      = "0";
              IntroStartOffset                    = "0";
              MaximumFingerprintPointDifferences  = 6;
              MaximumTimeSkip                     = 3.5;
              InvertedIndexShift                  = 2;
              SilenceDetectionMaximumNoise        = "-50";
              SilenceDetectionMinimumDuration     = "0.33";
              MaxParallelism                      = "2";
              ProcessThreads                      = "0";
              ProcessPriority                     = "BelowNormal";
              UseFileTransformationPlugin         = false;
              SkipbuttonHideDelay                 = "8";
              EnableMainMenu                      = true;
              FileTransformationPluginEnabled     = false;
            };
          };
        };
      };

      # Seerr ------------------------------------
      # Media Request and Discovery
      #-------------------------------------------

      seerr = {
        enable                = true;

        apiKey = {
          _secret             = config.sops.secrets."seerr/api_key".path;
        };
      };

      # Navidrome --------------------------------
      # Music Streaming
      #-------------------------------------------

      #navidrome = {
      #  enable                = true;
      #  users = {
      #    "User" = {
      #      userName          = "user";
      #      isAdmin           = true;
      #      password._secret  = config.sops.secrets."navidrome/password".path;
      #    };
      #  };
      #
      #  settings = {
      #    MusicFolder         = "/data/media/music";
      #  };
      #};
    };

    systemd.services.protonvpn-port-forward = lib.mkIf (config.nixflix.vpn.enable && qbCfg.vpn.enable) {
      description = "ProtonVPN port forwarding for qBittorrent";
      after = [
        "${config.systemd.services.qbittorrent.vpnConfinement.vpnNamespace}.service"
        "qbittorrent.service"
      ];
      requires = [
        "${config.systemd.services.qbittorrent.vpnConfinement.vpnNamespace}.service"
        "qbittorrent.service"
      ];
      wantedBy = [ "multi-user.target" ];

      path = [
        pkgs.curl
        pkgs.jq
        pkgs.libnatpmp
        pkgs.iproute2
        pkgs.gawk
      ];

      serviceConfig = {
        Type = "simple";
        Restart = "on-failure";
        RestartSec = "5s";
        ExecStart =
          let
            ns = config.systemd.services.qbittorrent.vpnConfinement.vpnNamespace;
            qbHost = "http://${qbCfg.serverConfig.Preferences.WebUI.Address}:${toString config.services.qbittorrent.webuiPort}";
            qbUser = qbCfg.serverConfig.Preferences.WebUI.Username;
            qbPassFile = config.sops.secrets."qbittorrent/password".path;
          in
          pkgs.writeShellScript "protonvpn-port-forward" ''
            QB_HOST="${qbHost}"
            QB_USER="${qbUser}"
            QB_PASS=$(cat ${qbPassFile})

            QB_COOKIE=$(curl -s -c - --data "username=$QB_USER&password=$QB_PASS" \
              "$QB_HOST/api/v2/auth/login" | grep SID | awk '{print $NF}')

            CURRENT_PORT=$(curl -s -b "SID=$QB_COOKIE" \
              "$QB_HOST/api/v2/app/preferences" | jq '.listen_port')

            while true; do
              UDP_OUT=$(ip netns exec ${ns} natpmpc -a 1 0 udp 60 -g 10.2.0.1)
              ip netns exec ${ns} natpmpc -a 1 0 tcp 60 -g 10.2.0.1

              PORT=$(echo "$UDP_OUT" | grep "Mapped public port" | awk '{print $4}')

              if [ -z "$PORT" ]; then
                echo "Failed to get port, is the tunnel up?"
                sleep 5
                continue
              fi

              if [ "$PORT" != "$CURRENT_PORT" ]; then
                echo "Port changed: $CURRENT_PORT -> $PORT, updating qBittorrent..."
                curl -s -b "SID=$QB_COOKIE" \
                  --data "json={\"listen_port\":$PORT,\"random_port\":false}" \
                  "$QB_HOST/api/v2/app/setPreferences"
                curl -s -b "SID=$QB_COOKIE" \
                  --data "hashes=all" \
                  "$QB_HOST/api/v2/torrents/reannounce"
                CURRENT_PORT=$PORT
              fi

              sleep 45
            done
          '';
      };
    };
  };
}

#---------------------------------------------------------------------------------------------------
# End
#---------------------------------------------------------------------------------------------------
