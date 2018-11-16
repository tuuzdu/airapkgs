{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
}:

let
  pname = "rosboost_cfg";
  version = "1.14.4";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0ymdfrdhr0kkk4cxbrqs13jk5cjx4dc2w0s7ac78bv1sa91dhlgn";
  };

  propagatedBuildInputs = [ catkin ];

  meta = with stdenv.lib; {
    description = "Contains scripts used by the rosboost-cfg tool for determining cflags/lflags/etc. of boost on your system";
    homepage = http://wiki.ros.org/rosboost_cfg;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
