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
    sha256 = "0zbgd26pljc6li4i5r3khqg20jwxh7y0zywglgmd2m1hhr9yqrnr";
  };

  propagatedBuildInputs = [ python3 web3 ipfsapi ];

  meta = with stdenv.lib; {
    description = "Robonomics.network graph agent";
    homepage = http://github.com/airalab/aira-graph;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
