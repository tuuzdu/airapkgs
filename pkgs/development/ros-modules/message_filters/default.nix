{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, rosconsole
, rostest
, roscpp
, rosunit
, xmlrpcpp
}:

let
  pname = "message_filters";
  version = "1.13.6";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "ros-gbp";
    repo = "ros_comm-release";
    rev = "release/lunar/${pname}/${version}-0";
    sha256 = "0j7lzjj0dsrddn7k4v07c170zh27w1m1f9bkn3zhd2dzin7lzwp5";
  };

  propagatedBuildInputs = [ catkin rosconsole rostest roscpp rosunit xmlrpcpp ];

  meta = with stdenv.lib; {
    description = "A set of message filters which take in messages and may output those messages at a later time, based on the conditions that filter needs met";
    homepage = http://wiki.ros.org/message_filters;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
