{ lib
, fetchFromGitHub
, buildPythonPackage
, pythonOlder
, lru-dict 
, requests
, eth-abi
, eth-account
, websockets
}:

let
  pname = "web3";
  version = "4.6.0";
in buildPythonPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "${pname}.py";
    rev = "v${version}";
    sha256 = "1qvmnxq9j8j6mfbr56jrag9vh4pi3zv859nvzmh8jshhph5gsnnc";
  };

  propagatedBuildInputs = [ lru-dict requests eth-abi eth-account websockets ];

  disabled = pythonOlder "3.3";

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
