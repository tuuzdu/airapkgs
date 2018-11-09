{ stdenv, fetchFromGitHub, buildPythonPackage, pytest, pyhamcrest }:

buildPythonPackage rec {
  pname = "base58";
  version = "1.0.2";

  src = fetchFromGitHub {
    owner = "keis";
    repo = "base58";
    rev = "v${version}";
    sha256 = "0lagnb7vc1z4x9hxvx8zd41c8pc2h50n7gqs4bx1gdz3g4z8mgc3";
  };

  buildInputs = [ pytest pyhamcrest ];
  checkPhase = ''
    pytest
  '';

  meta = with stdenv.lib; {
    description = "Base58 and Base58Check implementation";
    homepage = https://github.com/keis/base58;
    license = licenses.mit;
    maintainers = with maintainers; [ nyanloutre ];
  };
}
