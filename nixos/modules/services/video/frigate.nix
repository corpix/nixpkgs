{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    any
    attrValues
    converge
    elem
    filterAttrsRecursive
    hasPrefix
    makeLibraryPath
    mkDefault
    mkEnableOption
    mkPackageOption
    mkIf
    mkOption
    optionalAttrs
    optionals
    types
    ;

  cfg = config.services.frigate;

  format = pkgs.formats.yaml { };

  filteredConfig = converge (filterAttrsRecursive (_: v: !elem v [ null ])) cfg.settings;

  cameraFormat =
    with types;
    submodule {
      freeformType = format.type;
      options = {
        ffmpeg = {
          inputs = mkOption {
            description = ''
              List of inputs for this camera.
            '';
            type = listOf (submodule {
              freeformType = format.type;
              options = {
                path = mkOption {
                  type = str;
                  example = "rtsp://192.0.2.1:554/rtsp";
                  description = ''
                    Stream URL
                  '';
                };
                roles = mkOption {
                  type = listOf (enum [
                    "audio"
                    "detect"
                    "record"
                  ]);
                  example = [
                    "detect"
                    "record"
                  ];
                  description = ''
                    List of roles for this stream
                  '';
                };
              };
            });
          };
        };
      };
    };

  # Discover configured detectors for acceleration support
  detectors = attrValues cfg.settings.detectors or { };
  withCoralUSB = any (d: d.type == "edgetpu" && hasPrefix "usb" d.device or "") detectors;
  withCoralPCI = any (d: d.type == "edgetpu" && hasPrefix "pci" d.device or "") detectors;
  withCoral = withCoralPCI || withCoralUSB;
in

{
  meta.buildDocsInSandbox = false;

  options.services.frigate = with types; {
    enable = mkEnableOption "Frigate NVR";

    package = mkPackageOption pkgs "frigate" { };

    vaapiDriver = mkOption {
      type = nullOr (enum [
        "i965"
        "iHD"
        "nouveau"
        "vdpau"
        "nvidia"
        "radeonsi"
      ]);
      default = null;
      example = "radeonsi";
      description = ''
        Force usage of a particular VA-API driver for video acceleration. Use together with `settings.ffmpeg.hwaccel_args`.

        Setting this *is not required* for VA-API to work, but it can help steer VA-API towards the correct card if you have multiple.

        :::{.note}
        For VA-API to work you must enable {option}`hardware.graphics.enable` (sufficient for AMDGPU) and pass for example
        `pkgs.intel-media-driver` (required for Intel 5th Gen. and newer) into {option}`hardware.graphics.extraPackages`.
        :::

        See also:

        - https://docs.frigate.video/configuration/hardware_acceleration
        - https://docs.frigate.video/configuration/ffmpeg_presets#hwaccel-presets
      '';
    };

    settings = mkOption {
      type = submodule {
        freeformType = format.type;
        options = {
          cameras = mkOption {
            type = attrsOf cameraFormat;
            description = ''
              Attribute set of cameras configurations.

              https://docs.frigate.video/configuration/cameras
            '';
          };

          database = {
            path = mkOption {
              type = path;
              default = "/var/lib/frigate/frigate.db";
              description = ''
                Path to the SQLite database used
              '';
            };
          };

          mqtt = {
            enabled = mkEnableOption "MQTT support";

            host = mkOption {
              type = nullOr str;
              default = null;
              example = "mqtt.example.com";
              description = ''
                MQTT server hostname
              '';
            };
          };
        };
      };
      default = { };
      description = ''
        Frigate configuration as a nix attribute set.

        See the project documentation for how to configure frigate.
        - [Creating a config file](https://docs.frigate.video/guides/getting_started)
        - [Configuration reference](https://docs.frigate.video/configuration/index)
      '';
    };
  };

  config = mkIf cfg.enable {
    hardware.coral = {
      usb.enable = mkDefault withCoralUSB;
      pcie.enable = mkDefault withCoralPCI;
    };

    users.users.frigate = {
      isSystemUser = true;
      group = "frigate";
    };
    users.groups.frigate = { };

    systemd.services.frigate = {
      after = [
        "go2rtc.service"
        "network.target"
      ];
      wantedBy = [
        "multi-user.target"
      ];
      environment =
        {
          CONFIG_FILE = "/run/frigate/frigate.yml";
          HOME = "/var/lib/frigate";
          PYTHONPATH = cfg.package.pythonPath;
        }
        // optionalAttrs (cfg.vaapiDriver != null) {
          LIBVA_DRIVER_NAME = cfg.vaapiDriver;
        }
        // optionalAttrs withCoral {
          LD_LIBRARY_PATH = makeLibraryPath (with pkgs; [ libedgetpu ]);
        };
      path =
        with pkgs;
        [
          # unfree:
          # config.boot.kernelPackages.nvidiaPackages.latest.bin
          ffmpeg-headless
          libva-utils
          procps
          radeontop
        ]
        ++ optionals (!stdenv.hostPlatform.isAarch64) [
          # not available on aarch64-linux
          intel-gpu-tools
          rocmPackages.rocminfo
        ];
      serviceConfig = {
        ExecStartPre = [
          (pkgs.writeShellScript "frigate-clear-cache" ''
            rm --recursive --force /var/cache/frigate/*
          '')
          (pkgs.writeShellScript "frigate-create-writable-config" ''
            cp --no-preserve=mode "${format.generate "frigate.yml" filteredConfig}" /run/frigate/frigate.yml
          '')
        ];
        ExecStart = "${cfg.package.python.interpreter} -m frigate";
        Restart = "on-failure";
        SyslogIdentifier = "frigate";

        User = "frigate";
        Group = "frigate";
        SupplementaryGroups = [ "render" ] ++ optionals withCoral [ "coral" ];

        AmbientCapabilities = optionals (elem cfg.vaapiDriver [
          "i965"
          "iHD"
        ]) [ "CAP_PERFMON" ]; # for intel_gpu_top

        UMask = "0027";

        StateDirectory = "frigate";
        StateDirectoryMode = "0750";

        # Caches
        PrivateTmp = true;
        CacheDirectory = "frigate";
        CacheDirectoryMode = "0750";

        # Sockets/IPC
        RuntimeDirectory = "frigate";
      };
    };
  };
}
