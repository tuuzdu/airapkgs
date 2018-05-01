{ lib
, fetchFromGitHub 
, buildPythonPackage
, eth-utils
}:

let
  pname = "eth-abi";
  version = "v1.0.0";
in buildPythonPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "${pname}";
    rev = "${version}";
    sha256 = "04jiwri35yz0sfnbpldc8ll484mxxlwraifi345nxp8g48w12c6g";
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
