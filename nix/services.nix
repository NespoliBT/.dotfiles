# Services

{
    services.printing.enable = true;
    services.openssh.enable = true;
    services.upower.enable = true;
    services.gvfs.enable = true;

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    services.blueman.enable = true;
}
