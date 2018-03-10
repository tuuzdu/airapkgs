{ lib
, fetchFromGitHub 
, buildPythonPackage
, eth-utils
}:

let
  pname = "eth-keys";
  version = "v0.2.0-beta.1";
in buildPythonPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "${pname}";
    rev = "${version}";
    sha256 = "0g0ydmgijcib093ky7hdla243hdjiv7yidpcpw275l7m29r0c54b";
  };

  propagatedBuildInputs = [ eth-utils ];

  prePatch = ''
    sed -i '/setuptools-markdown/d' setup.py
  '';

  meta = {
    description = "Common API for Ethereum key operations";
    homepage = https://github.com/ethereum/eth-keys;
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.akru ];
  };
}
