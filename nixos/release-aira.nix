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
    inherit (nixos') channel iso_minimal;
    tests = {
      inherit (nixos'.tests)
        parity;
    };
  };

  nixpkgs = {
    inherit (nixpkgs')
      parity
      parity-beta

      ros_comm
      rosserial
      mavros
      dji_sdk

      aira-graph
      robonomics_dev
      robonomics_comm
      robonomics-tools;
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
        (all nixpkgs.aira-graph)
        (all nixpkgs.robonomics_dev)
        (all nixpkgs.robonomics_comm)
        (all nixpkgs.robonomics-tools)
        (all nixpkgs.parity)
        (all nixpkgs.parity-beta)
      ]
      ++ lib.collect lib.isDerivation nixos;
  });

}
