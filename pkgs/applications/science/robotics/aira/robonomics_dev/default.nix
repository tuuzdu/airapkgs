{ stdenv
, mkRosPackage
, fetchFromGitHub
, ros_comm
, actionlib
, ros_opcua_communication
, python3Packages
}:

let
  pname = "robonomics_dev";
  version = "0.0.0";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "${pname}";
    rev = "master";
    sha256 = "0v3fymd1dvqwy8q1i22y0fvm1kq1n9fcgjqhnv1mrm0f6k63qljy";
  };

  propagatedBuildInputs = with python3Packages;
  [ ros_comm actionlib ros_opcua_communication ipfsapi
    numpy web3 google_api_python_client voluptuous multihash
  ];

  meta = with stdenv.lib; {
    description = "Robonomics development kit";
    homepage = http://github.com/airalab/robonomics_dev;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
