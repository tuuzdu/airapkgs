{ stdenv
, mkRosPackage
, fetchFromGitHub
, robonomics_comm_market
, robonomics_comm_control
, robonomics_comm_liability
}:

let
  pname = "robonomics_comm";
  version = "0.0.0";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_comm";
    rev = "release/${pname}-0";
    sha256 = "00w7k0si596picjvsix4ji2myvcpjnqsak6ni3gvglsijs8kmpnf";
  };

  propagatedBuildInputs = [ robonomics_comm_market robonomics_comm_control robonomics_comm_liability ];

  meta = with stdenv.lib; {
    description = "Robonomics communication stack meta-package";
    homepage = http://github.com/airalab/robonomics_comm;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
