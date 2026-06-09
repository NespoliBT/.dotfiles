{ ... }:
{
  services.hermes-agent = {
    enable = true;
    addToSystemPackages = true;
    # Provide API keys via an env file, e.g.:
    # environmentFiles = [ /run/secrets/hermes-env ];
  };
}
