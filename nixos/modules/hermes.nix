{ ... }:
{
  services.hermes-agent = {
    enable = true;

    # ── Model ────────────────────────────────────────────────────────────
    settings = {
      model = {
        provider = "nous";
        base_url = "https://inference-api.nousresearch.com/v1";
        default = "anthropic/claude-sonnet-4.6";
      };

      toolsets = [ "all" ];

      terminal = {
        backend = "local";
        cwd = ".";
        timeout = 180;
      };

      compression = {
        enabled = true;
        threshold = 0.85;
      };

      memory = {
        memory_enabled = true;
        user_profile_enabled = true;
      };

      display = {
        compact = false;
      };

      agent = {
        max_turns = 90;
        verbose = false;
      };
    };

    # ── Secrets ──────────────────────────────────────────────────────────
    # Plain file with restricted perms (600, owned by nespoli).
    # Contains: NOUS_API_KEY, TELEGRAM_BOT_TOKEN, TELEGRAM_ALLOWED_USERS,
    #           TELEGRAM_HOME_CHANNEL, FIRECRAWL_API_KEY
    environmentFiles = [
      "/home/nespoli/hermes-standalone/secrets/.env"
    ];

    # ── Messaging ────────────────────────────────────────────────────────
    extraDependencyGroups = [ "messaging" ];

    # ── CLI on PATH + share state between host shell and service ─────────
    addToSystemPackages = true;

    # ── Service tuning ───────────────────────────────────────────────────
    restart = "on-failure";
    restartSec = 5;
  };
}
