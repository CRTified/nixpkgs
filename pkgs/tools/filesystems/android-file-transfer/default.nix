{ stdenv, mkDerivation, fetchFromGitHub, cmake, fuse, readline, pkgconfig, qtbase, qttools }:

mkDerivation rec {
  pname = "android-file-transfer";
  version = "4.2";

  src = fetchFromGitHub {
    owner = "whoozle";
    repo = "android-file-transfer-linux";
    rev = "v${version}";
    sha256 = "125rq8ji83nw6chfw43i0h9c38hjqh1qjibb0gnf9wrigar9zc8b";
  };

  nativeBuildInputs = [ cmake readline pkgconfig ];
  buildInputs = [ fuse qtbase qttools ];

  meta = with stdenv.lib; {
    description = "Reliable MTP client with minimalistic UI";
    homepage = "https://whoozle.github.io/android-file-transfer-linux/";
    license = licenses.lgpl21;
    maintainers = [ maintainers.xaverdh ];
    platforms = platforms.linux;
  };
}
