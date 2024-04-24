{ stdenv
, fetchFromSourcehut
, fetchFromGitHub
, core-go ? fetchFromSourcehut {
  owner = "~sircmpwn";
  repo = "core-go";
  rev = "3c1346e6bbc37884ca5eb390e22728e4c40e3fa5";
  hash = "sha256-jCbPNZ+rQiLQSJF/XN5aQGn0IA2h0GXUdzg1XHUJIzE=";
}
, core-go-patches ? [./patches/core-go.auditlog-ip.patch]
, unzip
, gqlgenVersion
}:
let
  core-go-mod = stdenv.mkDerivation {
    name = "core-go";
    src = core-go;

    patches = core-go-patches;
    phases = ["unpackPhase" "patchPhase" "installPhase"];
    installPhase = ''
      mkdir $out
      cp -r --reflink=auto ./* ./.* $out/
    '';
  };
  redigo-mod = stdenv.mkDerivation {
    name = "redigo";
    src = fetchFromGitHub {
      owner = "gomodule";
      repo = "redigo";
      rev = "v2.0.0";
      hash = "sha256-8zrbDkA5IPHeKJogs+cBRJbAwIB2bMCdDo+sIwDS580=";
    };

    patches = [./patches/redigo.unix-socket.patch];
    phases = ["unpackPhase" "patchPhase" "installPhase"];
    installPhase = ''
      mkdir $out
      cp -r --reflink=auto ./* ./.* $out/
    '';
  };
  # gocelery-mod = stdenv.mkDerivation {
  #   name = "gocelery";
  #   src = fetchFromGitHub {
  #     owner = "gocelery";
  #     repo = "gocelery";
  #     rev = "825d89059344006c104412e628d456b3a111a6a5";
  #     hash = "sha256-3AVHQDYEVQo+k9YE8i3Rra79Ca/kQHLGH/qi3KLYF7M=";
  #   };

  #   patches = [./patches/gocelery.deps.patch];
  #   phases = ["unpackPhase" "patchPhase" "installPhase"];
  #   installPhase = ''
  #     mkdir $out
  #     cp -r --reflink=auto ./* ./.* $out/
  #   '';
  # };
in {
  overrideModAttrs = (_: {
    # No need to workaround -trimpath: it's not used in goModules,
    # but do download `go generate`'s dependencies nonetheless.
    preBuild = ''
      if [ -d ./loaders ]; then go generate ./loaders; fi
      if [ -d ./graph ]; then go generate ./graph; fi
    '';
  });

  # Workaround this error:
  #   go: git.sr.ht/~emersion/go-emailthreads@v0.0.0-20220412093310-4fd792e343ba: module lookup disabled by GOPROXY=off
  #   tidy failed: go mod tidy failed: exit status 1
  #   graph/generate.go:10: running "go": exit status 1
  proxyVendor = true;

  nativeBuildInputs = [ unzip ];

  postConfigure = ''
    echo >> ../go.mod
    echo 'replace git.sr.ht/~sircmpwn/core-go => ${core-go-mod}' >> ../go.mod
    echo 'replace github.com/gomodule/redigo => ${redigo-mod}' >> ../go.mod
  '';

  # Workaround -trimpath in the package derivation:
  # https://github.com/99designs/gqlgen/issues/1537
  # This is to give `go generate ./graph` access to gqlgen's *.gotpl files
  # If it fails, the gqlgenVersion may have to be updated.
  preBuild = ''
    unzip ''${GOPROXY#"file://"}/github.com/99designs/gqlgen/@v/v${gqlgenVersion}.zip
    if [ -d ./loaders ]; then go generate ./loaders; fi
    if [ -d ./graph ]; then go generate ./graph; fi
    rm -rf github.com
  '';
}
