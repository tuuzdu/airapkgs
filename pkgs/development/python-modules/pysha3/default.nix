{ lib
, fetchurl
, buildPythonPackage
}:

let
  pname = "pysha3";
  version = "1.0.2";
in buildPythonPackage rec {
  name = "${pname}-${version}";

  src = fetchurl {
    url = "mirror://pypi/${builtins.substring 0 1 pname}/${pname}/${name}.tar.gz";
    sha256 = "17kkjapv6sr906ib0r5wpldmzw7scza08kv241r98vffy9rqx67y";
  };

  meta = {
    description = "SHA-3 (Keccak) for Python";
    homepage = https://github.com/tiran/pysha3;
    license = lib.licenses.psfl;
    maintainers = [ lib.maintainers.akru ];
  };
}
