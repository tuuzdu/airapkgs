{ lib
, fetchurl
, buildPythonPackage
, pytest
, pluggy
, six
}:

let
  pname = "rlp";
  version = "0.6.0";
in buildPythonPackage rec {
  name = "${pname}-${version}";
  src = fetchurl {
    url = "mirror://pypi/${builtins.substring 0 1 pname}/${pname}/${name}.tar.gz";
    sha256 = "0d3gx4mp8q4z369s5yk1n9c55sgfw9fidbwqxq67d6s7l45rm1w7";
  };

  checkInputs = [ pytest pluggy six ];

  meta = {
    description = "A Python implementation of Recursive Length Prefix encoding (RLP)";
    homepage = https://github.com/ethereum/pyrlp;
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.akru ];
  };
}
