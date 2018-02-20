{ stdenv, mkRosPackage, fetchFromGitHub
, catkin, message_generation, std_srvs, ros_opcua_msgs }:

mkRosPackage {
  name = "ros_opcua_srvs";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "ros_opcua_communication";
    rev = "release/ros_opcua_srvs-0";
    sha256 = "132q14h4d8yr5kljgla5az2zzmclck0qkqprcdm00bhdbmixm0pw";
  };

  propagatedBuildInputs = [ catkin message_generation std_srvs ros_opcua_msgs ];

  maintainers = [ stdenv.lib.maintainers.akru ];
}
