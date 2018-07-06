{ stdenv, fetchPypi, python, buildPythonPackage, gmp }:

buildPythonPackage rec {
  version = "3.6.3";
  pname = "pycryptodome";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0ha53vmssffdap74jvd06az5kdwrzz0czrddjs6fhgi748ii8blv";
  };

  meta = {
    homepage = https://www.pycryptodome.org/;
    description = "Python Cryptography Toolkit";
    platforms = stdenv.lib.platforms.unix;
  };
}
