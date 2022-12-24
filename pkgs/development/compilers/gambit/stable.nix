{ callPackage, fetchFromGitHub }:

callPackage ./build.nix rec {
  version = "4.9.4";
  src = fetchFromGitHub {
    owner = "gambit";
    repo = "gambit";
    rev = "v${version}";
    sha256 = "sha256-TrJ8ZsOThQ7zFuNyf6y5A3qodUCv9+/8wnYmWyeGMIQ=";
  };
}
