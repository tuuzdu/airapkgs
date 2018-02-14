{ lib
, fetchFromGitHub 
, buildPythonPackage
, attrdict
, eth-keyfile
, eth-utils
, eth-rlp
}:

let
  pname = "eth-account";
  version = "v0.1.0-alpha.2";
in buildPythonPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "${pname}";
    rev = "${version}";
    sha256 = "16caxwphnd02bhn4k4l4rbiy5vdcscgm34p6ny829gmdaiiq06fp";
  };

  propagatedBuildInputs = [ attrdict eth-keyfile eth-utils eth-rlp ];

  prePatch = ''
    sed -i '/setuptools-markdown/d' setup.py
  '';

  meta = {
    description = "Sign Ethereum transactions and messages with local private keys";
    homepage = https://github.com/ethereum/eth-account;
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.akru ];
  };
}
