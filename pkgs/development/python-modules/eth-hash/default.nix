{ lib
, fetchFromGitHub
, buildPythonPackage
, pycryptodome
, pysha3
}:

let
  pname = "eth-hash";
  version = "v0.1.0-alpha.3";
in buildPythonPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "${pname}";
    rev = "${version}";
    sha256 = "1q8067hpk352vy0b1kckrw33wfpl0c126036nw2d6n3h1sl45c0f";
  }; 

  propagatedBuildInputs = [ pycryptodome pysha3 ];

  prePatch = ''
    sed -i '/setuptools-markdown/d' setup.py
  '';

  meta = {
    description = "The Ethereum hashing function";
    homepage = https://github.com/ethereum/eth-hash;
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.akru ];
  };
}
