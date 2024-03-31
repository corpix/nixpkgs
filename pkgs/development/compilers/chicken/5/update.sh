#!/usr/bin/env nix-shell
#! nix-shell -I nixpkgs=../../../../.. -p chicken -i bash
set -e

export URL_PREFIX="https://code.call-cc.org/egg-tarballs/5/"
chicken_nixpkgs=$(pwd)
cd $(nix-prefetch-url \
     'https://code.call-cc.org/cgi-bin/gitweb.cgi?p=eggs-5-latest.git;a=snapshot;h=master;sf=tgz' \
     --name chicken-eggs-5-latest --unpack --print-path | tail -1)

echo "# THIS IS A GENERATED FILE.  DO NOT EDIT!" > $chicken_nixpkgs/deps.toml
for item in */*/*.egg
do
  export EGG_NAME=$(dirname $(dirname $item))
  export EGG_VERSION=$(basename $(dirname $item))
  export EGG_URL="${URL_PREFIX}${EGG_NAME}/${EGG_NAME}-${EGG_VERSION}.tar.gz"
  export EGG_SHA256=$(nix-prefetch-url $EGG_URL)
  csi -s $chicken_nixpkgs/read-egg.scm < $item
done >> $chicken_nixpkgs/deps.toml
