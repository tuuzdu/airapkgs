{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, cpp_common
, rostime
}:

mkRosPackage rec {
  name = "${pname}-${version}";
  pname = "xmlrpcpp";
  version = "1.14.4";
  rosdistro = "melodic";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0yj9wiwmd95cp6y06mb0bni6adqv9ph1k4vw5z3k0s469wq5dg33";
  };

  propagatedBuildInputs = [ catkin cpp_common rostime ];

  meta = with stdenv.lib; {
    description = "C++ implementation of the XML-RPC protocol";
    homepage = http://wiki.ros.org/xmlrpcpp;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
