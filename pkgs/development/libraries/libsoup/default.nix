{ stdenv, fetchurl, glib, libxml2, meson, ninja, pkgconfig, gnome3
, gnomeSupport ? true, sqlite, glib-networking, gobject-introspection, vala
, libpsl, python3, brotli }:

stdenv.mkDerivation rec {
  pname = "libsoup";
  version = "2.70.0";

  src = fetchurl {
    url = "mirror://gnome/sources/${pname}/${stdenv.lib.versions.majorMinor version}/${pname}-${version}.tar.xz";
    sha256 = "0hjk9lgppc5435my0lyywbpmj7ib5vvcylwfin8ki97g9bvj1c2l";
  };

  postPatch = ''
    patchShebangs libsoup/
  '';

  outputs = [ "out" "dev" ];

  buildInputs = [ python3 sqlite libpsl brotli ];
  nativeBuildInputs = [ meson ninja pkgconfig gobject-introspection vala glib ];
  propagatedBuildInputs = [ glib libxml2 ];

  mesonFlags = [
    "-Dtls_check=false" # glib-networking is a runtime dependency, not a compile-time dependency
    "-Dgssapi=disabled"
    "-Dvapi=enabled"
    "-Dgnome=${if gnomeSupport then "true" else "false"}"
    "-Dntlm=disabled"
  ];

  doCheck = false; # ERROR:../tests/socket-test.c:37:do_unconnected_socket_test: assertion failed (res == SOUP_STATUS_OK): (2 == 200)

  passthru = {
    propagatedUserEnvPackages = [ glib-networking.out ];
    updateScript = gnome3.updateScript {
      packageName = pname;
    };
  };

  meta = {
    description = "HTTP client/server library for GNOME";
    homepage = "https://wiki.gnome.org/Projects/libsoup";
    license = stdenv.lib.licenses.gpl2;
    inherit (glib.meta) maintainers platforms;
  };
}
