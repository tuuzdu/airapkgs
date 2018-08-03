{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
, message_generation
, message_runtime
, geographic_msgs
, sensor_msgs
}:

let
  pname = "mavros_msgs";
  version = "0.26.1";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "mavlink";
    repo = "mavros-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0y1jknssvgpaz6hrj9wnrbynhqxpi9b58qli09lwl89qs5rm5rf4";
  };

  propagatedBuildInputs = [ catkin message_generation message_runtime geographic_msgs sensor_msgs ];

  meta = with stdenv.lib; {
    description = "MAVLink extendable communication node messages.";
    homepage = https://github.com/mavlink/mavros;
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = [ maintainers.akru ];
  };
}
