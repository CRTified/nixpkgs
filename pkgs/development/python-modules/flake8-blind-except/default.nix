{ lib, fetchPypi, buildPythonPackage }:

buildPythonPackage rec {
  pname = "flake8-blind-except";
  version = "0.1.1";
  src = fetchPypi {
    inherit pname version;
    sha256 = "16g58mkr3fcn2vlfhp3rlahj93qswc7jd5qrqp748mc26dk3b8xc";
  };
  meta = {
    homepage = "https://github.com/elijahandrews/flake8-blind-except";
    description = "A flake8 extension that checks for blind except: statements";
    maintainers = with lib.maintainers; [ johbo ];
    license = lib.licenses.mit;
  };
}
