{ stdenv
, mkRosPackage
, fetchFromGitHub
, python3Packages
, ros_comm
, nav_msgs
, sensor_msgs
, geometry_msgs
, diagnostic_msgs
}:

mkRosPackage rec {
  name = "${pname}-${version}";
  pname = "rosserial";
  version = "0.8.0";
  rosdistro = "melodic";

  src = fetchFromGitHub {
    owner = "akru";
    repo = pname;
    rev = "eda32bcfa5294f4ca128a834cd54de9f8f39471d";
    sha256 = "0j243jp3vqr0h90dsx2sqzw2jmmqb1nsnczby6shrb2m4ll3jh3k";
  };

  propagatedBuildInputs = with python3Packages;
  [ ros_comm geometry_msgs nav_msgs sensor_msgs diagnostic_msgs pyserial ];

  meta = with stdenv.lib; {
    description = "A ROS client library for small, embedded devices, such as Arduino.";
    homepage = http://wiki.ros.org/rosserial;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
