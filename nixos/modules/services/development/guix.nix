{config, pkgs, lib, ...}:

with lib;

let

  cfg = config.services.guix;

  guix-binary = pkgs.stdenv.mkDerivation rec
    { name = "guix-binary-${version}";
      version = "0.16.0";

      src = pkgs.fetchurl {
        # TODO: make work on non x86_64 systems
        url = "https://alpha.gnu.org/gnu/guix/guix-binary-${version}.x86_64-linux.tar.xz";
        sha256 = "049l0zim30cd0gyly2h3jaw4cshdk78h7xdb9ac173h72i13afbj";
      };
      sourceRoot = ".";

      outputs = [ "out" "store" "var" ];
      phases = [ "unpackPhase" "installPhase" ];

      installPhase = ''
        # copy the /gnu/store content
        mkdir -p $store
        cp -r gnu $store

        # copy /var content
        mkdir -p $var
        cp -r var $var

        # link guix binaries
        mkdir -p $out/bin
        ln -s /var/guix/profiles/per-user/root/current-guix/bin/guix $out/bin/guix
        ln -s /var/guix/profiles/per-user/root/current-guix/bin/guix-daemon $out/bin/guix-daemon
      '';
    };

  buildGuixUser = i:
    {
      "guixbuilder${builtins.toString i}" = {
        group = "guixbuild";
        extraGroups = ["guixbuild"];
        home = "/var/empty";
        shell = pkgs.nologin;
        description = "Guix build user ${builtins.toString i}";
        isSystemUser = true;
      };
    };

in {

  options.services.guix = {
    enable = mkEnableOption "GNU Guix package manager";
  };

  config = mkIf (cfg.enable) {

    users = {
      extraUsers = lib.fold (a: b: a // b) {} (builtins.map buildGuixUser (lib.range 1 10));
      extraGroups.guixbuild = {name = "guixbuild";};
    };

    environment.systemPackages = [ guix-binary ];

    systemd.services.guix-daemon = {
      enable = true;
      description = "Build daemon for GNU Guix";
      serviceConfig = {
        ExecStart="/var/guix/profiles/per-user/root/current-guix/bin/guix-daemon --build-users-group=guixbuild";
        Environment="GUIX_LOCPATH=/var/guix/profiles/per-user/root/guix-profile/lib/locale";
        RemainAfterExit="yes";
        StandardOutput="syslog";
        StandardError="syslog";
        TaskMax= "8192";
      };
      wantedBy = [ "multi-user.target" ];
    };

    system.activationScripts.guix = ''

      # copy initial /gnu/store
      if [ ! -d /gnu/store ]
      then
        mkdir -p /gnu
        cp -ra ${guix-binary.store}/gnu/store /gnu/
      fi

      # copy initial /var/guix content
      if [ ! -d /var/guix ]
      then
        mkdir -p /var
        cp -ra ${guix-binary.var}/var/guix /var/
      fi

      # root profile
      if [ ! -d ~root/.config/guix ]
      then
        mkdir -p ~root/.config/guix
        ln -sf /var/guix/profiles/per-user/root/current-guix \
          ~root/.config/guix/current
      fi

      # authorize substitutes
      GUIX_PROFILE="`echo ~root`/.config/guix/current"; source $GUIX_PROFILE/etc/profile
      guix archive --authorize < ~root/.config/guix/current/share/guix/ci.guix.info.pub
    '';

    environment.shellInit = ''
      export GUIX_LOCPATH="$HOME/.guix-profile/lib/locale"
      export PATH="$HOME/.guix-profile/bin:$PATH"

      # TODO: This does not seem to work. INFOPATH seems to be set somewhere else.
      export INFOPATH="$HOME/.guix-profile/share/info:$INFOPATH"
    '';
  };

}
