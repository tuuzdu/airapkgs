{ lib
, fetchFromGitHub 
, buildPythonPackage
, eth-utils
}:

let
  pname = "eth-abi";
  version = "v1.0.0-beta.0";
in buildPythonPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "${pname}";
    rev = "${version}";
    sha256 = "0cck9lxll0i19qnd8d51d3n6q647h76q6q1s2vbjq6a3v65v2cxf";
  };

  propagatedBuildInputs = [ eth-utils ];

  prePatch = ''
    sed -i '/setuptools-markdown/d' setup.py
  '';

  meta = {
    description = "Ethereum ABI Utils";
    homepage = https://github.com/ethereum/eth-abi;
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.akru ];
  };
}
