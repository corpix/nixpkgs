{ stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "minio";
  version = "2019-12-30T05-45-39Z";

  src = fetchFromGitHub {
    owner = "minio";
    repo = "minio";
    rev = "RELEASE.${version}";
    sha256 = "0awd5qxh9wx5f281mf5rppzk6dw87xp5j6z120bcvr26kkkqv1az";
  };

  modSha256 = "1a8lhhx82fik4pgr6xr4n8fwx3zhahj9ily3kd4bprb67myr4fm2";
  subPackages = [ "." ];

  buildFlagsArray = [''-ldflags=
    -X github.com/minio/minio/cmd.ReleaseTag=${version}
  ''];

  meta = with stdenv.lib; {
    homepage = https://www.minio.io/;
    description = "An S3-compatible object storage server";
    maintainers = with maintainers; [ eelco bachp ];
    platforms = platforms.unix;
    license = licenses.asl20;
  };
}
