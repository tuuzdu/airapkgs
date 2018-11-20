{ config, lib, pkgs, ... }:

with lib;

{
  imports =
    [ ../virtualisation/virtualbox-image.nix
      ../installer/cd-dvd/channel.nix
      ../profiles/clone-config.nix
    ];

  # FIXME: UUID detection is currently broken
  boot.loader.grub.fsIdentifier = "provided";

  # Disable X11 for minimal image
  virtualisation.virtualbox.guest.x11 = false;
}
