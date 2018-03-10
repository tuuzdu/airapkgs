{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
}:

let
  pname = "rosboost_cfg";
  version = "1.14.1";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "051psvfx6qw9swia21azk45cwzm9wvpnfjyfh3sy7b6ri0h8zyhj";
  };

  propagatedBuildInputs = [ catkin ];

  meta = with stdenv.lib; {
    description = "Contains scripts used by the rosboost-cfg tool for determining cflags/lflags/etc. of boost on your system";
    homepage = http://wiki.ros.org/rosboost_cfg;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
