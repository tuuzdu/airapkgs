{ stdenv, mkRosPackage, fetchFromGitHub, catkin
, ros_opcua_msgs, ros_opcua_srvs, ros_opcua_impl_freeopcua }:

mkRosPackage {
  name = "ros_opcua_communication";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "ros_opcua_communication";
    rev = "release/ros_opcua_communication-0";
    sha256 = "1plmbc04xd289vsdicvxmadgxjcvrz1gl56bdprp2j6dk62vvzb3";
  };

  propagatedBuildInputs = [ catkin ros_opcua_msgs ros_opcua_srvs ros_opcua_impl_freeopcua ];

  maintainers = [ stdenv.lib.maintainers.akru ];
}
