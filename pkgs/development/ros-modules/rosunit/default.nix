{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, roslib
}:

let
  pname = "rosunit";
  version = "1.14.1";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "1iaj6fx1fdfwvl35ng9dz87jp75fk28vrmmqjq2ky53k5jdhl8ka";
  };

  propagatedBuildInputs = [ catkin roslib ];

  meta = with stdenv.lib; {
    description = "Unit-testing package for ROS";
    homepage = http://wiki.ros.org/rosunit;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
