# This jobset is used to generate a NixOS channel that contains a
# small subset of Nixpkgs, mostly useful for servers that need fast
# security updates.

{ nixpkgs ? { outPath = (import ../lib).cleanSource ./..; revCount = 56789; shortRev = "gfedcba"; }
, stableBranch ? false
, supportedSystems ? [ "x86_64-linux" "aarch64-linux" ] # no i686-linux
}:

let

  nixpkgsSrc = nixpkgs; # urgh

  pkgs = import ./.. {};

  lib = pkgs.lib;

  nixos' = import ./release.nix {
    inherit stableBranch supportedSystems;
    nixpkgs = nixpkgsSrc;
  };

  nixpkgs' = builtins.removeAttrs (import ../pkgs/top-level/release.nix {
    inherit supportedSystems;
    nixpkgs = nixpkgsSrc;
  }) [ "unstable" ];

in rec {

  nixos = {
    inherit (nixos') channel manual iso_minimal docker_image dummy;
    tests = {
      inherit (nixos'.tests)
        containers-imperative
        containers-ipv4
        firewall
        ipv6
        login
        nat
        openssh
        predictable-interface-names
        proxy
        simple;
      installer = {
        inherit (nixos'.tests.installer)
          simple;
      };
      boot = {
        inherit (nixos'.tests.boot)
          biosCdrom;
      };
    };
  };

  nixpkgs = {
    inherit (nixpkgs')
      git
      linux
      openssh
      python
      stdenv
      tarball
      vim

      parity
      parity-beta

      ros_comm
      mavros
      dji_sdk

      robonomics_dev
      robonomics_comm;
  };

  tested = lib.hydraJob (pkgs.releaseTools.aggregate {
    name = "nixos-${nixos.channel.version}";
    meta = {
      description = "Release-critical builds for the AIRA channel";
      maintainers = [ lib.maintainers.akru ];
    };
    constituents =
      let all = x: map (system: x.${system}) supportedSystems; in
      [ nixpkgs.tarball
        (all nixpkgs.robonomics_dev)
        (all nixpkgs.robonomics_comm)
        (all nixpkgs.parity)
        (all nixpkgs.parity-beta)
      ]
      ++ lib.collect lib.isDerivation nixos;
  });

}
