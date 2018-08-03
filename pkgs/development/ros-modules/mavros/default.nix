{ stdenv
, mkRosPackage
, fetchFromGitHub
, catkin
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

let
  pname = "mavros";
  version = "0.26.1";
  rosdistro = "melodic";

in mkRosPackage {
  name = "${pname}-${version}";

  src = fetchFromGitHub {
    owner = "mavlink";
    repo = "mavros-release";
    rev = "release/${rosdistro}/${pname}/${version}-0";
    sha256 = "1bxjw7qhscshxnmj64nk8gl4scypy191vynjisn8p0s7sl2637sh";
  };

  propagatedBuildInputs = [
    catkin diagnostic_updater pluginlib rosconsole
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
