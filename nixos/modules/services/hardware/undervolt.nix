{ config, pkgs, lib, ... }:

with lib;
let
  cfg = config.services.undervolt;
in
{
  options.services.undervolt = {
    enable = mkEnableOption ''
       Undervolting service for Intel CPUs.

       Warning: This service is not endorsed by Intel and may permanently damage your hardware. Use at your own risk!
    '';

    verbose = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to enable verbose logging.
      '';
    };

    package = mkOption {
      type = types.package;
      default = pkgs.undervolt;
      defaultText = "pkgs.undervolt";
      description = ''
        undervolt derivation to use.
      '';
    };

    coreOffset = mkOption {
      type = types.nullOr types.int;
      default = null;
      description = ''
        The amount of voltage in mV to offset the CPU cores by.
      '';
    };

    gpuOffset = mkOption {
      type = types.nullOr types.int;
      default = null;
      description = ''
        The amount of voltage in mV to offset the GPU by.
      '';
    };

    uncoreOffset = mkOption {
      type = types.nullOr types.int;
      default = null;
      description = ''
        The amount of voltage in mV to offset uncore by.
      '';
    };

    analogioOffset = mkOption {
      type = types.nullOr types.int;
      default = null;
      description = ''
        The amount of voltage in mV to offset analogio by.
      '';
    };

    temp = mkOption {
      type = types.nullOr types.int;
      default = null;
      description = ''
        The temperature target in Celsius degrees.
      '';
    };

    tempAc = mkOption {
      type = types.nullOr types.int;
      default = null;
      description = ''
        The temperature target on AC power in Celsius degrees.
      '';
    };

    tempBat = mkOption {
      type = types.nullOr types.int;
      default = null;
      description = ''
        The temperature target on battery power in Celsius degrees.
      '';
    };

    useTimer = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to set a timer that applies the undervolt settings every 30s.
        This will cause spam in the journal but might be required for some
        hardware under specific conditions.
        Enable this if your undervolt settings don't hold.
      '';
    };
  };

  config = mkIf cfg.enable {
    boot.kernelModules = [ "msr" ];

    environment.systemPackages = [ cfg.package ];

    systemd.services.undervolt = {
      path = [ pkgs.undervolt ];

      description = "Intel Undervolting Service";

      # Apply undervolt on boot, nixos generation switch and resume
      wantedBy = [ "multi-user.target" "post-resume.target" ];
      after = [ "post-resume.target" ]; # Not sure why but it won't work without this

      serviceConfig = {
        Type = "oneshot";
        Restart = "no";

        # `core` and `cache` are both intentionally set to `cfg.coreOffset` as according to the undervolt docs:
        #
        #     Core or Cache offsets have no effect. It is not possible to set different offsets for
        #     CPU Core and Cache. The CPU will take the smaller of the two offsets, and apply that to
        #     both CPU and Cache. A warning message will be displayed if you attempt to set different offsets.
        ExecStart = let
          arguments = concatStringsSep " "
            (filter (s: s != "") [
              (optionalString cfg.verbose                  "--verbose")
              (optionalString (cfg.coreOffset != null)     "--core ${cfg.coreOffset}")
              (optionalString (cfg.coreOffset != null)     "--cache ${cfg.coreOffset}")
              (optionalString (cfg.gpuOffset != null)      "--gpu ${cfg.gpuOffset}")
              (optionalString (cfg.uncoreOffset != null)   "--uncore ${cfg.uncoreOffset}")
              (optionalString (cfg.analogioOffset != null) "--analogio ${cfg.analogioOffset}")
              (optionalString (cfg.temp != null)           "--temp ${cfg.temp}")
              (optionalString (cfg.tempAc != null)         "--temp-ac ${cfg.tempAc}")
              (optionalString (cfg.tempBat != null)        "--temp-bat ${cfg.tempBat}")
            ]);
        in "${pkgs.undervolt}/bin/undervolt ${arguments}";
      };
    };

    systemd.timers.undervolt = mkIf cfg.useTimer {
      description = "Undervolt timer to ensure voltage settings are always applied";
      partOf = [ "undervolt.service" ];
      wantedBy = [ "multi-user.target" ];
      timerConfig = {
        OnBootSec = "2min";
        OnUnitActiveSec = "30";
      };
    };
  };
}
