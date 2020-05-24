{ mkDerivation, lib, fetchFromGitHub, cmake }:

mkDerivation rec {
  pname = "qxmpp";
  version = "1.2.1";

  src = fetchFromGitHub {
    owner = "${pname}-project";
    repo = pname;
    rev = "v${version}";
    sha256 = "004kqb9b3c1s1l2yivfs47c9284ccqkdhhq5qv7nq4nw572fjrmg";
  };

  nativeBuildInputs = [
    cmake
  ];

  meta = with lib; {
    description = "Cross-platform C++ XMPP client and server library";
    homepage = "https://github.com/qxmpp-project/qxmpp";
    platforms = platforms.linux;
    license = with licenses; [ lgpl21Plus ];
    maintainers = with maintainers; [ ajs124 ];
  };
}
