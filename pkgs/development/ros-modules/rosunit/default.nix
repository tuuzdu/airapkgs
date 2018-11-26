{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, roslib
}:

let
  pname = "rosunit";
  version = "1.14.4";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0czgdsy7acg32a6vhshfk61m8gqay1qv65v8i9fi4r4zc235d0sh";
  };

  patches = [ ./print_report_stream_write_argument_type_fix.patch ];

  propagatedBuildInputs = [ catkin roslib ];

  meta = with stdenv.lib; {
    description = "Unit-testing package for ROS";
    homepage = http://wiki.ros.org/rosunit;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
