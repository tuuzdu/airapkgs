{ lib
, fetchFromGitHub 
, buildPythonPackage
, eth-utils
, parsimonious
, pytest
, hypothesis
}:

let
  pname = "eth-abi";
  version = "1.1.1";
in buildPythonPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "${pname}";
    rev = "v${version}";
    sha256 = "0irnn656rmwm23b7p88sfdgnfm1dbpqra08l6x3lkdj2ajnq6lsh";
  };

  buildInputs = [ pytest hypothesis ];
  propagatedBuildInputs = [ eth-utils parsimonious ];

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
