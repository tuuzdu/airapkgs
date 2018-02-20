{ stdenv, mkRosPackage, fetchFromGitHub, catkin, message_generation, std_msgs }:

mkRosPackage {
  name = "ros_opcua_msgs";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "ros_opcua_communication";
    rev = "release/ros_opcua_msgs-0";
    sha256 = "0rwxvvlsv4p0jq98dvigx2kyc0c58a4xqrs3l4sp6h27rcxpb353";
  };

  propagatedBuildInputs = [ catkin message_generation std_msgs ];

  maintainers = [ stdenv.lib.maintainers.akru ];
}
