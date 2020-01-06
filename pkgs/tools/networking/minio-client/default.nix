{ stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "minio-client";
  version = "2019-12-24T23-41-36Z";

  src = fetchFromGitHub {
    owner = "minio";
    repo = "mc";
    rev = "RELEASE.${version}";
    sha256 = "0q90ln46z8i7gzh2fs1iv1mkf1fp24bj6ad6igdhsas067fv85bg";
  };

  modSha256 = "0kjhhincjkl28nmbpvywxknlpidivbbczl0k8xfl7crgzxypm381";
  subPackages = [ "." ];

  buildFlagsArray = [''-ldflags=
    -X github.com/minio/mc/cmd.ReleaseTag=${version}
  ''];

  meta = with stdenv.lib; {
    homepage = https://github.com/minio/mc;
    description = "A replacement for ls, cp, mkdir, diff and rsync commands for filesystems and object storage";
    maintainers = with maintainers; [ eelco bachp ];
    platforms = platforms.unix;
    license = licenses.asl20;
  };
}
