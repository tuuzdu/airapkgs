{ stdenv 
, fetchFromGitHub
, python3Packages
, python3
}:

with python3Packages;

let
  pname = "aira-graph";
  version = "0.1";

in buildPythonApplication rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "aira-graph";
    rev = "master";
    sha256 = "1h9cpx0aisrmy8z9f9zbb4dj9j977ibwd76h5c3d4m84jx22f3cw";
  };

  propagatedBuildInputs = [ python3 web3 ipfsapi ];

  meta = with stdenv.lib; {
    description = "Robonomics.network graph agent";
    homepage = http://github.com/airalab/aira-graph;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
