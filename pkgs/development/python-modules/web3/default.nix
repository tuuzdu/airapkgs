{ lib
, fetchFromGitHub
, buildPythonPackage
, lru-dict 
, requests
, eth-abi
, eth-account
, websockets
}:

let
  pname = "web3";
  version = "v4.2.0";
in buildPythonPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "${pname}.py";
    rev = "${version}";
    sha256 = "1rr0m4ra6gv5xd4yxhd5rnqwvsxn1s1gaqc362b9if4grxr2nnjr";
  };

  patches = [ ./bytes32_array_fix.patch ];

  propagatedBuildInputs = [ lru-dict requests eth-abi eth-account websockets ];

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
