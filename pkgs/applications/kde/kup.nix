{
  stdenv, mkDerivation, lib,
  extra-cmake-modules, kdoctools, makeWrapper,
  bup, rsync, libgit2,
  kcoreaddons, kdbusaddons, ki18n, kio, solid,
  kidletime, knotifications, kconfig, kinit, kjobwidgets,
  plasma-framework
}:

mkDerivation {
  name = "kup";
  nativeBuildInputs = [ extra-cmake-modules kdoctools makeWrapper ];
  buildInputs = [
    libgit2
    kcoreaddons kdbusaddons ki18n kio solid
    kidletime knotifications kconfig kinit kjobwidgets
    plasma-framework
  ];
  postInstall = ''
    for v in `ls $out/bin/*`
    do
      wrapProgram $v --prefix PATH : ${lib.makeBinPath [ bup rsync ]}
    done
  '';
}
