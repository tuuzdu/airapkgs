{ stdenv
, cmake
, catkin
, python3Packages
, python3
}:

attrs:

stdenv.mkDerivation (attrs // rec {
  propagatedBuildInputs = with python3Packages;
    [ python3 cmake catkin_pkg rospkg catkin ] ++ (attrs.propagatedBuildInputs or []);

  # Disable testing by default
  doCheck = attrs.doCheck or false;

  ROS_LANG_DISABLE = "geneus:genlisp:gennodejs";

  cmakeFlags = "-DCATKIN_ENABLE_TESTING=${if doCheck then "ON" else "OFF"} -DSETUPTOOLS_DEB_LAYOUT=OFF";

  preConfigure = ''
    if [ ! -e CMakeLists.txt ]; then
      catkin_init_workspace
    fi
  '';

  postFixup = attrs.postFixup or ''
    mkdir -p $out/nix-support && printf "${catkin}:''$out" > ros-paths

    # Collect ROS paths
    test -f $pkg/nix-support/propagated-build-inputs && \
      for i in $propagatedBuildInputs; do
        test -f $i/nix-support/ros-paths && \
          printf ":$i:$(cat $i/nix-support/ros-paths)" >> ros-paths
      done

    # Optimize ROS paths
    ${python3.interpreter} -c "print(':'.join(set(open('ros-paths').read().split(':'))))" > ''$out/nix-support/ros-paths

    # Store ROS paths to env file
    echo "export ROS_PACKAGE_PATH=\"`cat ''$out/nix-support/ros-paths`\"" >> ''$out/setup.sh
  '';
})
