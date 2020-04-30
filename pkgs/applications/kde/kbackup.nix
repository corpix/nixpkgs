{
  mkDerivation, lib,
  extra-cmake-modules, kdoctools,
  kio, ki18n, shared-mime-info
}:

mkDerivation {
  name = "kbackup";
  nativeBuildInputs = [ extra-cmake-modules kdoctools ];
  propagatedBuildInputs = [
    kio ki18n shared-mime-info
  ];
  outputs = [ "out" "dev" ];
}
