{ lib
, fetchurl
, buildPythonPackage
}:

let
  pname = "base58";
  version = "0.2.4";
in buildPythonPackage rec {
  name = "${pname}-${version}";

  src = fetchurl {
    url = "mirror://pypi/${builtins.substring 0 1 pname}/${pname}/${name}.tar.gz";
    sha256 = "130mh7sqdlfawi0vyrva88rqdi5nc9aks0s15y0gn6m8qz5lvjwp";
  };

  meta = {
    description = "Base58 and Base58Check implementation";
    homepage = https://github.com/keis/base58;
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.akru ];
  };
}
