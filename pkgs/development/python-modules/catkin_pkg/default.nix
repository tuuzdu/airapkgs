{ stdenv
, fetchPypi
, buildPythonPackage
, pyparsing
, docutils
, dateutil
}:

let
  pname = "catkin_pkg";
  version = "0.4.1";
  sha256 = "0wm9ali5329ci0jhlqcfcn7i859ri0h3ly752006mam7jjggdgma";

in buildPythonPackage rec { 
  name = "${pname}-${version}";
  src = fetchPypi { inherit pname version sha256; };

  prePatch = ''
    sed -i '/argparse/d' setup.py
  '';

  propagatedBuildInputs = [ pyparsing docutils dateutil ];

  meta = with stdenv.lib; {
    description = "Standalone Python library for the catkin package system";
    homepage = http://wiki.ros.org/catkin_pkg;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  }; 
}
