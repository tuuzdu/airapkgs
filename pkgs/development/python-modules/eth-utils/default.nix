{ lib
, fetchFromGitHub 
, buildPythonPackage
, cytoolz
, eth-hash 
}:

let
  pname = "eth-utils";
  version = "v1.0.3";
in buildPythonPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "${pname}";
    rev = "${version}";
    sha256 = "0c4sgzvb18yyg86rdnfw91jgnl4zikmk3n8gaya1507nk6071rcj";
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
