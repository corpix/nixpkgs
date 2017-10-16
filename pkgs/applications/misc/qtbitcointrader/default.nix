{ stdenv, fetchurl, qt5 }:

let
  version = "1.40.09";
in
stdenv.mkDerivation {
  name = "qtbitcointrader-${version}";

  src = fetchurl {
    url = "https://github.com/JulyIGHOR/QtBitcoinTrader/archive/v${version}.tar.gz";
    sha256 = "1h34lbjx5n3g6zsb5k5vng8bdnm211ca3xk1s6cnl28yjvv9hq67";
  };

  buildInputs = [ qt5.qtbase qt5.qtmultimedia qt5.qtscript ];

  postUnpack = "sourceRoot=\${sourceRoot}/src";

  configurePhase = ''
    runHook preConfigure
    qmake $qmakeFlags \
      PREFIX=$out \
      DESKTOPDIR=$out/share/applications \
      ICONDIR=$out/share/pixmaps \
      QtBitcoinTrader_Desktop.pro
    runHook postConfigure
  '';

  meta = with stdenv.lib;
    { description = "Bitcoin trading client";
      homepage = https://centrabit.com/;
      license = licenses.lgpl3;
      platforms = qt5.qtbase.meta.platforms;
      maintainers = [ maintainers.ehmry ];
    };
}
