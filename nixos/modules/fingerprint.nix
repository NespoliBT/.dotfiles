{ config, pkgs, ... }:
{
  services.fprintd.package = pkgs.fprintd.override {
    libfprint = pkgs.libfprint-focaltech-2808-a658;
  };
}
