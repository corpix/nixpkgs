{ mkDerivation, lib, fetchFromGitLab, extra-cmake-modules
, kirigami2
, knotifications
, qtquickcontrols2
, qxmpp
, qt5
, zxing-cpp }:

mkDerivation rec {
  pname = "kaidan";
  version = "0.5.0";

  src = fetchFromGitLab {
    owner = "kde";
    repo = pname;
    domain = "invent.kde.org";
    rev = "v${version}";
    sha256 = "0g82rqbf1w52yfkff7p4fxckqaig6xivv9bb8kw40jw77y7612qh";
  };

  nativeBuildInputs = [
    extra-cmake-modules
  ];

  propagatedBuildInputs = [
    kirigami2
    knotifications
    qtquickcontrols2
    qt5.qtmultimedia
    qt5.qtlocation
    qxmpp
    zxing-cpp
  ];

  meta = with lib; {
    description = "Simple and user-friendly Jabber/XMPP client for every device and platform";
    homepage = "https://invent.kde.org/kde/kaidan/";
    platforms = platforms.linux;
    license = with licenses; [ gpl3Plus mit asl20 ];
    maintainers = with maintainers; [ ajs124 ];
  };
}
