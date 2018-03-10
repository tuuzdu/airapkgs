{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, message_generation
, message_runtime
}:

let
  pname = "std_srvs";
  version = "1.11.2";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm_msgs-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "1lrc01bxlh4arcjaxa1vlzvhvcp5xd4ia0g01pbblmmhvyfy06s7";
  };

  propagatedBuildInputs = [ catkin message_generation message_runtime ];

  meta = with stdenv.lib; {
    description = "Common service definitions";
    homepage = http://wiki.ros.org/std_srvs;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
