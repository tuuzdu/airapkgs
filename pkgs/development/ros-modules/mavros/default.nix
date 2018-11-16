{ stdenv
, mkRosPackage
, fetchFromGitHub
, diagnostic_updater
, geographic_msgs
, sensor_msgs
, nav_msgs
, std_srvs
, rosconsole
, pluginlib
, tf2_ros
, tf2_eigen
, angles
, libmavconn
, rosconsole_bridge
, eigen_conversions
, mavros_msgs
, geographiclib 
}:

mkRosPackage rec {
  name = "${pname}-${version}";
  pname = "mavros";
  version = "0.27.0";
  rosdistro = "melodic";

  src = fetchFromGitHub {
    owner = "mavlink";
    repo = "mavros-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "17m0vlj2hzmrf0ysi7l5frfhy0xif1a2430hd5s3vh1kg5mwn2kz";
  };

  propagatedBuildInputs = [
    diagnostic_updater pluginlib rosconsole
    sensor_msgs nav_msgs geographic_msgs std_srvs
    tf2_ros tf2_eigen angles libmavconn rosconsole_bridge
    eigen_conversions mavros_msgs geographiclib
  ];

  meta = with stdenv.lib; {
    description = "MAVLink extendable communication node for ROS with proxy for Ground Control Station.";
    homepage = https://github.com/mavlink/mavro;
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = [ maintainers.akru ];
  };
}
