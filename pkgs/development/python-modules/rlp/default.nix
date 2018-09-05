{ lib
, fetchPypi
, buildPythonPackage
, eth-utils
, hypothesis
, pytest
}:

buildPythonPackage rec {
  pname = "rlp";
  version = "1.0.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "07nz53xx5p4yb95r7nr90qfh7z49r7540v487aajfgd25wbva3q4";
  };

  checkInputs = [ pytest hypothesis ];
  propagatedBuildInputs = [ eth-utils ];

  # setuptools-markdown uses pypandoc which is broken at the moment
  preConfigure = ''
    substituteInPlace setup.py --replace \'setuptools-markdown\' ""
    substituteInPlace setup.py --replace "long_description_markdown_filename='README.md'," ""
  '';

  checkPhase = ''
    pytest .
  '';

  meta = {
    description = "A package for encoding and decoding data in and from Recursive Length Prefix notation";
    homepage = "https://github.com/ethereum/pyrlp";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ gebner ];
  };
}
