{ stdenv
, mkRosPackage
, fetchFromGitHub
, ros_environment
, rospack
, boost
}:

mkRosPackage rec {
  name = "${pname}-${version}";
  pname = "roslib";
  version = "1.14.4";
  rosdistro = "melodic";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1a9xp0qfihhsls8ab89qdxvn4cr0kw4r7516ddi7h4d8j9cx9crd";
  };

  buildInputs = [ boost ];
  propagatedBuildInputs = [ rospack ros_environment ];

  meta = with stdenv.lib; {
    description = "Base dependencies and support libraries for ROS";
    homepage = http://wiki.ros.org/roslib;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
