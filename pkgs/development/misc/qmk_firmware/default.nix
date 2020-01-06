{ stdenv, fetchFromGitHub
, avrgcc, avrbinutils
, gcc-arm-embedded, gcc-armhf-embedded
, teensy-loader-cli, dfu-programmer, dfu-util }:

let version = "0.7.105"; 
in stdenv.mkDerivation {
  pname = "qmk_firmware";
  inherit version;

  src = fetchFromGitHub {
    owner = "qmk";
    repo = "qmk_firmware";
    rev = version;
    sha256 = "19jaqr8fp7mrhbnq76zy3aiwj8myz2jcknr4r7ycq541aha7hsjs";
    fetchSubmodules = true;
  };
  postPatch = ''
    substituteInPlace tmk_core/arm_atsam.mk \
      --replace arm-none-eabi arm-none-eabihf
    rm keyboards/handwired/frenchdev/rules.mk keyboards/dk60/rules.mk
  '';
  buildFlags = [ "all:default" ];
  doCheck = true;
  checkTarget = "test:all";
  installPhase = ''
    mkdir $out
  '';

  NIX_CFLAGS_COMPILE = "-Wno-error";

  nativeBuildInputs = [
    avrgcc
    avrbinutils
    gcc-arm-embedded
    gcc-armhf-embedded
    teensy-loader-cli
    dfu-programmer
    dfu-util
  ];
}
