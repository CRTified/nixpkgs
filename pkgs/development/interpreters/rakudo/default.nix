{ stdenv, fetchurl, perl, icu, zlib, gmp, lib, nqp }:

stdenv.mkDerivation rec {
  pname = "rakudo";
  version = "2020.06";

  src = fetchurl {
    url    = "https://www.rakudo.org/dl/rakudo/rakudo-${version}.tar.gz";
    sha256 = "06kj8vfkkspmcdyd3zf2pyxwmijbbfnhv3jcaihvb8p3za5gxn2c";
  };

  buildInputs = [ icu zlib gmp perl ];
  configureScript = "perl ./Configure.pl";
  configureFlags = [
    "--backends=moar"
    "--with-nqp=${nqp}/bin/nqp"
  ];

  # Some tests fail on Darwin
  doCheck = !stdenv.isDarwin;

  meta = with stdenv.lib; {
    description = "Raku implementation on top of Moar virtual machine";
    homepage    = "https://www.rakudo.org";
    license     = licenses.artistic2;
    platforms   = platforms.unix;
    maintainers = with maintainers; [ thoughtpolice vrthra sgo ];
  };
}
