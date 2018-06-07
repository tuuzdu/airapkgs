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
  version = "4.3.0";
in buildPythonPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "${pname}.py";
    rev = "v${version}";
    sha256 = "0zvcbfcdxx8pmc7q8yiiv2dy83qw4v7nazxps42h866syz36ablv";
  };

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
