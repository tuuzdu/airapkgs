{ stdenv 
, fetchFromGitHub
, python3Packages
, python3
}:

with python3Packages;

buildPythonApplication rec {
  name = "${pname}-${version}";
  pname = "aira-graph";
  version = "0.2";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = pname;
    rev = "v${version}";
    sha256 = "1vshvsznzazg2iz2fswj125g5gzyh54n5125lvz8iwdj1fmrc7nk";
  };

  propagatedBuildInputs = [ python3 web3 ipfsapi ];

  meta = with stdenv.lib; {
    description = "Robonomics.network graph agent";
    homepage = http://github.com/airalab/aira-graph;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
