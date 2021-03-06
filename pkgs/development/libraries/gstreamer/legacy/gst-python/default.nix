{ fetchurl, stdenv, pkgconfig, python2Packages, gstreamer, gst-plugins-base
}:

let
  inherit (python2Packages) python pygobject2;
in stdenv.mkDerivation rec {
  name = "gst-python-0.10.22";

  src = fetchurl {
    urls = [
      "${meta.homepage}/src/gst-python/${name}.tar.bz2"
      "mirror://gentoo/distfiles/${name}.tar.bz2"
      ];
    sha256 = "0y1i4n5m1diljqr9dsq12anwazrhbs70jziich47gkdwllcza9lg";
  };

  hardeningDisable = [ "bindnow" ];

  # Need to disable the testFake test case due to bug in pygobject.
  # See https://bugzilla.gnome.org/show_bug.cgi?id=692479
  patches = [ ./disable-testFake.patch ];

  buildInputs =
    [ pkgconfig gst-plugins-base pygobject2 ]
    ;

  propagatedBuildInputs = [ gstreamer python ];

  meta = {
    homepage = "https://gstreamer.freedesktop.org";

    description = "Python bindings for GStreamer";

    license = stdenv.lib.licenses.lgpl2Plus;
    platforms = stdenv.lib.platforms.unix;
  };
}
