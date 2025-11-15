{ config, pkgs, ... }: {
  services.sshd.enable = true;
  services.x2goserver.enable = true;
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 443 5900 ];
}
