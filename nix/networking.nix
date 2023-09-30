# Networking

{
    networking.hostName = "nespoli"; 
    networking.wireless.enable = true;
    networking.wireless.userControlled.enable = true;

    networking.wireless.networks.eduroam = {
        auth = ''
            key_mgmt=WPA-EAP
            eap=PEAP
            identity="d.nespoli1@campus.unimib.it"
            anonymous_identity="d.nespoli1@campus.unimib.it"
            password=""
        '';
    };

    networking.wireless.networks."MatteoCiccione - 5GHz".psk="stomentendo1";
    networking.wireless.networks."Braccio Destro [5G] Pfizer".psk="nonmiricordo";
}
