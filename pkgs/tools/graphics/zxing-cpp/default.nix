{ stdenv
, fetchFromGitHub
, cmake
, autoconf }:

stdenv.mkDerivation rec {
  pname = "zxing-cpp";
  version = "1.0.8";

  outputs = [ "out" ];
  nativeBuildInputs = [ cmake autoconf ];

  src = fetchFromGitHub {
    owner = "nu-book";
    repo = "zxing-cpp";
    rev = "v" + version;
    sha256 = "011sq8wcjfxbnd8sj6bf2fgkamlp8gj6q835g61c952npvwsnl71";
  };

}
