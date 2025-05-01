# Services

{
  users.users.root.extraGroups = [ "docker" ];
  services.printing.enable = true;
  services.openssh.enable = true;
  services.upower.enable = true;
  services.gvfs.enable = true;
  services.getty.autologinUser = "nespoli";
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.blueman.enable = true;
}
