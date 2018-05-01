{ lib
, fetchFromGitHub
, buildPythonPackage
, pycryptodome
, pysha3
}:

let
  pname = "eth-hash";
  version = "v0.1.2";
in buildPythonPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "${pname}";
    rev = "${version}";
    sha256 = "1pfrfrzwqm0i8z8n8ha234zqw750gplwnpvbnihpy99yv34xa0j5";
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
