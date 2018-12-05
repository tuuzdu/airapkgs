{ stdenv
, buildPythonPackage
, fetchFromGitHub
, nose
, six
}:

buildPythonPackage rec {
  version = "0.8.1";
  pname = "parsimonious";

  src = fetchFromGitHub {
    repo = "parsimonious";
    owner = "erikrose";
    rev = version;
    sha256 = "1c6nb3jl9zpp7lbi2x12663xxnavrqi421rlch0gyaknnl680z2s";
  };

  propagatedBuildInputs = [ nose six ];

  meta = with stdenv.lib; {
    homepage = "https://github.com/erikrose/parsimonious";
    description = "Fast arbitrary-lookahead parser written in pure Python";
    license = licenses.mit;
  };

}
