{ lib
, fetchFromGitHub 
, buildPythonPackage
, eth-utils
, parsimonious
, pytest
, hypothesis
}:

let
  pname = "eth-abi";
  version = "1.2.2";
in buildPythonPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "${pname}";
    rev = "v${version}";
    sha256 = "0v3y2qp6k6z9my6cxjbq2jkjb5qcf1bkngca04pqv8i73y5k7v3q";
  };

  buildInputs = [ pytest hypothesis ];
  propagatedBuildInputs = [ eth-utils parsimonious ];

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
