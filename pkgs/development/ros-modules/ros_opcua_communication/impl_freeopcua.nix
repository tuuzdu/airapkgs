{ stdenv, mkRosPackage, fetchFromGitHub
, catkin, roscpp, ros_opcua_srvs, freeopcua, libxml2 }:

mkRosPackage {
  name = "ros_opcua_impl_freeopcua";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "ros_opcua_communication";
    rev = "release/ros_opcua_impl_freeopcua-0";
    sha256 = "0vsabqqip447dj1rw139jmlp7l3vg81j6kxalzsaqzd9c8yiadiz";
  };

  propagatedBuildInputs = [ catkin roscpp ros_opcua_srvs freeopcua libxml2 ];

  maintainers = [ stdenv.lib.maintainers.akru ];
}
