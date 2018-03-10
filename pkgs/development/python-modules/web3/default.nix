{ lib
, fetchFromGitHub
, buildPythonPackage
, lru-dict 
, requests
, eth-abi
, eth-account
}:

let
  pname = "web3";
  version = "v4.0.0-beta.9";
in buildPythonPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "${pname}.py";
    rev = "${version}";
    sha256 = "1wjh84jlcwblbj3xhmyy2vmwxkdncmj2smk0pf8xnxrvy8vb07az";
  };

  patches = [ ./bytes32_array_fix.patch ];

  propagatedBuildInputs = [ lru-dict requests eth-abi eth-account ];

  # No testing
  doCheck = false;

  prePatch = ''
    sed -i '/setuptools-markdown/d' setup.py
  '';

  meta = {
    description = "A python interface for interacting with the Ethereum blockchain and ecosystem.";
    homepage = https://github.com/ethereum/web3.py;
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.akru ];
  };
}
