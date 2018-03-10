{ lib
, fetchFromGitHub 
, buildPythonPackage
, eth-utils
, hexbytes
, rlp
}:

let
  pname = "eth-rlp";
  version = "v0.1.0-alpha.2";
in buildPythonPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "${pname}";
    rev = "${version}";
    sha256 = "0i7kfnpc083x8nmd39rzv57x4ixc7jbixxm9z198sl9rlfsf3hyc";
  };

  propagatedBuildInputs = [ eth-utils hexbytes rlp ];

  prePatch = ''
    sed -i '/setuptools-markdown/d' setup.py
  '';

  meta = {
    description = "RLP definitions for common Ethereum objects in Python";
    homepage = https://github.com/ethereum/eth-rlp;
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.akru ];
  };
}
