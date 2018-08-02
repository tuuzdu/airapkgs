{ lib
, fetchPypi
, buildPythonPackage
, pythonOlder
}:

buildPythonPackage rec {
  pname = "websockets";
  version = "5.0.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0x16n60cy856kwbz7glnf8fndff3l7l7h5if89arv8d7nmfk37d4";
  };

  disabled = pythonOlder "3.3";
  doCheck = false; # protocol tests fail

  meta = {
    description = "WebSocket implementation in Python 3";
    homepage = https://github.com/aaugustin/websockets;
    license = lib.licenses.bsd3;
  };
}
