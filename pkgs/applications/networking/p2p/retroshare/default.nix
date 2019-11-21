{ stdenv, mkDerivation, fetchFromGitHub, cmake ,autoconf, libupnp, gpgme, gnome3, glib, libssh, pkgconfig, protobuf, bzip2
, libXScrnSaver, speex, curl, libxml2, libxslt, sqlcipher, libmicrohttpd, opencv, qmake, ffmpeg
, qtmultimedia, qtx11extras, qttools }:

mkDerivation rec {
  pname = "retroshare";
  version = "master";

  src = fetchFromGitHub {
    owner = "RetroShare";
    repo = "RetroShare";
    rev = "b6f61d113c6e9438a688ac977d7121e8baf2ea05";
    sha256 = "00kbw4rv8dky8v3fi1ka4gv2wrs1qbil4xfrcs3kv2qgs2swby7l";
    fetchSubmodules = true;
  };

  # NIX_CFLAGS_COMPILE = [ "-I${glib.dev}/include/glib-2.0" "-I${glib.dev}/lib/glib-2.0/include" "-I${libxml2.dev}/include/libxml2" "-I${sqlcipher}/include/sqlcipher" ];

  nativeBuildInputs = [ pkgconfig qmake ];
  buildInputs = [
    cmake autoconf
    speex libupnp gpgme gnome3.libgnome-keyring glib libssh qtmultimedia qtx11extras qttools
    protobuf bzip2 libXScrnSaver curl libxml2 libxslt sqlcipher libmicrohttpd opencv ffmpeg
  ];

  preConfigure = ''
    qmakeFlags="$qmakeFlags DESTDIR=$out"
  '';

  postInstall = ''
    ls -la
    # BT DHT bootstrap
    cp libbitdht/src/bitdht/bdboot.txt $out/share/retroshare
  '';

  meta = with stdenv.lib; {
    description = "";
    homepage = https://retroshare.cc;
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    maintainers = [ maintainers.domenkozar ];
  };
}
