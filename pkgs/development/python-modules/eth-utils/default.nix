{ lib
, fetchFromGitHub 
, buildPythonPackage
, cytoolz
, eth-hash 
}:

let
  pname = "eth-utils";
  version = "v1.0.0-beta.1";
in buildPythonPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "${pname}";
    rev = "${version}";
    sha256 = "0s14k2h5836hqn186ig7fyflr5ag185vdw0r0c7pd1bipjqksbja";
  };

  propagatedBuildInputs = [ cytoolz eth-hash ];

  prePatch = ''
    sed -i '/setuptools-markdown/d' setup.py
  '';

  meta = {
    description = "Utility functions for working with ethereum related codebases";
    homepage = https://github.com/ethereum/eth-utils;
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.akru ];
  };
}
