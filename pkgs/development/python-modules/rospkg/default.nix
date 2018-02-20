{ stdenv
, fetchPypi
, buildPythonPackage
, pyyaml
}:

let
  version = "1.1.4";
  pname = "rospkg";
  sha256 = "0g2hjqia34l57zkyq2n4lzxhnjv7j63wcjv8m7d7rf35yq2xzvs2";

in buildPythonPackage rec { 
  name = "${pname}-${version}";
  src = fetchPypi { inherit pname version sha256; };

  propagatedBuildInputs = [ pyyaml ];

  meta = with stdenv.lib; {
    description = "Standalone Python library for the ROS package system";
    homepage = http://wiki.ros.org/rospkg;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  }; 
}
