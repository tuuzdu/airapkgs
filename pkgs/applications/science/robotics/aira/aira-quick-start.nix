{ stdenv 
, fetchFromGitHub
, python3Packages
, python3
}:

with python3Packages;

let
  pname = "aira-quick-start";
  version = "0.0";

in buildPythonApplication rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "aira-quick-start";
    rev = "master";
    sha256 = "18vgd36yrf1hafjy78dc1g4wqwmwww7l44jykrhhvcnan4fwscim";
  };

  propagatedBuildInputs = [ python3 web3 termcolor ];

  meta = with stdenv.lib; {
    description = "AIRA destribution quick setup script";
    homepage = http://github.com/airalab/aira-quick-start;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
