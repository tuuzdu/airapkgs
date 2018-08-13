{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, djiosdk
, nav_msgs
, roscpp
, rospy
, sensor_msgs
, glibcLocales
, tf
}:

let
  pname = "dji_sdk";
  version = "3.6.0";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "dji-sdk";
    repo = "Onboard-SDK-ROS";
    rev = "${version}";
    sha256 = "08icpaja0kk231l8w0np4wxi2rlk4jbf91sm0ybqsddcyw6akka7";
  };
  
  propagatedBuildInputs = [ tf glibcLocales catkin djiosdk nav_msgs roscpp rospy sensor_msgs ];

  preConfigure = ''
    export LC_ALL="en_US.UTF-8"
    rm -rf dji_sdk_demo
    mv dji_sdk/* .
    rmdir dji_sdk
  '';

  meta = with stdenv.lib; {
    description = "Official ROS packages for DJI onboard SDK.";
    homepage = https://github.com/dji-sdk/Onboard-SDK-ROS;
    maintainers = [ maintainers.akru ];
  };
}
