{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, roscpp
, ros_opcua_srvs
, freeopcua
, libxml2
, pkgconfig
}:

let
  pname = "ros_opcua_impl_freeopcua";
  version = "0.2.0";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "airalab";
    repo = "ros_opcua_communication";
    rev = "release/${pname}-0";
    sha256 = "0vsabqqip447dj1rw139jmlp7l3vg81j6kxalzsaqzd9c8yiadiz";
  };

  propagatedBuildInputs = [ catkin roscpp ros_opcua_srvs freeopcua libxml2 pkgconfig ];

  meta = with stdenv.lib; {
    description = "Bindings for freeopcua - Open Source C++ OPC-UA Server and Client Library";
    homepage = http://wiki.ros.org/ros_opcua_impl_freeopcua;
    license = licenses.lgpl3;
    maintainers = [ maintainers.akru ];
  };
}
