{ stdenv
, mkRosPackage
, fetchFromGitHub
, message_generation
, message_runtime
, geographic_msgs
, sensor_msgs
}:

mkRosPackage rec {
  name = "${pname}-${version}";
  pname = "mavros_msgs";
  version = "0.27.0";
  rosdistro = "melodic";

  src = fetchFromGitHub {
    owner = "mavlink";
    repo = "mavros-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "0kcjwjqkgg43skg62xxkjqmzkr0g13xgs5lc32sl73i6ss298rck";
  };

  propagatedBuildInputs = [ message_generation message_runtime geographic_msgs sensor_msgs ];

  meta = with stdenv.lib; {
    description = "MAVLink extendable communication node messages.";
    homepage = https://github.com/mavlink/mavros;
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = [ maintainers.akru ];
  };
}
