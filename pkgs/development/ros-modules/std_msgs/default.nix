{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, message_generation
, message_runtime
}:

let
  pname = "std_msgs";
  version = "0.5.11";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "std_msgs-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "0wb2c2m0c7ysfwmyanrkx7n1iy0xr7fawjp2vf6xmk5469jz2l9b";
  };

  propagatedBuildInputs = [ catkin message_generation message_runtime ];

  meta = with stdenv.lib; {
    description = "Common message types representing primitive data types and other basic message constructs";
    homepage = http://wiki.ros.org/std_msgs;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
