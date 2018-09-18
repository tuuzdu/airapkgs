{ stdenv 
, fetchFromGitHub
, robonomics_comm
, mkRosPackage
}:

let
  pname = "hello_aira";
  version = "0.0.0";

in mkRosPackage rec {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "robonomics_tutorials";
    rev = "release/${pname}/${version}";
    sha256 = "0847j0k5phq1md93957w0b419g7argfzyn14v25alcarsk7xfsdh";
  };

  propagatedBuildInputs = [ robonomics_comm ];

  meta = with stdenv.lib; {
    description = "AIRA preinstalled zero-action tutorial"; 
    homepage = http://github.com/airalab/aira_tutorials;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
