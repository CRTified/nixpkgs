{ stdenv, buildPythonPackage, fetchPypi, pythonOlder, pytest, setuptools, structlog, pytest-asyncio, flaky, tornado, pycurl, pytest-httpbin }:

buildPythonPackage rec {
  pname = "nvchecker";
  version = "1.6.post1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "7d2e889a4ba2eeb75dd6649ed5e99f8cbfed45b2194657e8f46c978ec58d4175";
  };

  propagatedBuildInputs = [ setuptools structlog tornado pycurl ];
  checkInputs = [ pytest pytest-asyncio flaky pytest-httpbin ];

  # disable `test_ubuntupkg` because it requires network
  checkPhase = ''
    py.test -m "not needs_net" --ignore=tests/test_ubuntupkg.py
  '';

  disabled = pythonOlder "3.5";

  meta = with stdenv.lib; {
    homepage = "https://github.com/lilydjwg/nvchecker";
    description = "New version checker for software";
    license = licenses.mit;
    maintainers = with maintainers; [ marsam ];
  };
}
