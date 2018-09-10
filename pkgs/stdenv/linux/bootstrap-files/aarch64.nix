{
  busybox = import <nix/fetchurl.nix> {
    url = http://nixos-arm.dezgeg.me/bootstrap-aarch64-2017-03-11-bb3ef8/busybox;
    sha256 = "12qcml1l67skpjhfjwy7gr10nc86gqcwjmz9ggp7knss8gq8pv7f";
    executable = true;
  };
  bootstrapTools = import <nix/fetchurl.nix> {
    url = http://nixos-arm.dezgeg.me/bootstrap-aarch64-2017-03-11-bb3ef8/bootstrap-tools.tar.xz;
    sha256 = "0gc59si8hdgz8bysh3h8rpn5r5p4m6qfxmivii469z3l4q3xjxab";
  };
}
