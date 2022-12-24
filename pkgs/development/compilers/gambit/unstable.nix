{ callPackage, fetchFromGitHub, gambit-support }:

callPackage ./build.nix {
  version = "4.9.4-1234-g0a3dy4ij8";
  src = fetchFromGitHub {
    owner = "feeley";
    repo = "gambit";
    rev = "eb287205c10b3bcf5f497b33b520f468837a18ec";
    sha256 = "sha256-ePG3E5HCrdKML2dJU1mP0jEpEIdNzm+7V4UqBzC2I6o=";
  };
  gambit-params = gambit-support.unstable-params;
}
