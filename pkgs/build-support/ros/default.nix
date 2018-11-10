{ stdenv
, cmake
, catkin
, python3
, python3Packages
}:

attrs:

let
  pyEnv = with python3Packages;
    [ python3 empy catkin_pkg rospkg catkin cmake ];

in stdenv.mkDerivation (attrs // rec {
  propagatedBuildInputs = pyEnv ++ (attrs.propagatedBuildInputs or []);

  # Disable testing by default
  doCheck = attrs.doCheck or false;

  ROS_LANG_DISABLE = "geneus:genlisp:gennodejs";

  cmakeFlags = "-DCATKIN_ENABLE_TESTING=${if doCheck then "ON" else "OFF"} -DSETUPTOOLS_DEB_LAYOUT=OFF";

  preConfigure = ''
    if [ ! -e CMakeLists.txt ]; then
      catkin_init_workspace
    fi
  '';

  postInstall = attrs.postInstall or ''
    pushd ..
    if [ -f 'package.xml' ]; then
      cp package.xml ''$out
    fi
    if [ -d 'resources' ]; then
      cp -r resources ''$out
    fi
    if [ -d 'images' ]; then
      cp -r images ''$out
    fi
    if [ -d 'env-hooks' ]; then
      cp -r env-hooks ''$out
    fi
    popd
  '';

  postFixup = attrs.postFixup or ''
    find "''$prefix" -type f -perm -0100 | while read f; do
      if [ "''$(head -1 "''$f" | head -c+2)" != '#!' ]; then
        # missing shebang => not a script
        continue
      fi
      sed -i 's|#!\(/nix/store/.*/python\)|#!/usr/bin/env \1|' "''$f"
    done
  '';
})
