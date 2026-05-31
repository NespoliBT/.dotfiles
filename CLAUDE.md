# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Apply the system configuration

```bash
# From the nixos/ directory (or use the helper script):
sudo nixos-rebuild switch --flake /home/nespoli/.dotfiles/nixos#nespoli --show-trace

# Or use the convenience script at repo root:
bash /home/nespoli/.dotfiles/switch.sh
```

## Architecture overview

This is a NixOS + Hyprland dotfiles repo. Everything is managed through a single NixOS flake — there are no manual symlinks or stow configurations.

### NixOS flake (`nixos/`)

Entry point: `nixos/flake.nix`

- **`nixos/configuration/system.nix`** — base NixOS system config (bootloader, networking, users, hardware)
- **`nixos/configuration/home.nix`** — home-manager root, imports all per-app dotfile modules and declares user packages
- **`nixos/configuration/dotfiles/`** — per-application home-manager modules (hyprland, vim, git, alacritty, gtk, caelestia, vscodium, zen)
- **`nixos/modules/`** — NixOS system-level modules (pipewire, bluetooth, fish, fonts, flatpak, syncthing, fingerprint); aggregated via `modules/default.nix`

Flake inputs: `nixpkgs` (unstable), `home-manager`, `caelestia-shell`, `zen-browser`.

The `caelestia-shell` input is passed as `extraSpecialArgs` to home-manager so `configuration/home.nix` and `dotfiles/caelestia.nix` can reference it directly.

### Hyprland config (`hypr/`)

Raw Hyprland config files — not managed by home-manager options. The `dotfiles/hyprland.nix` module wraps the Hyprland binary with `--config $HOME/.dotfiles/hypr/hyprland.conf`, so changes to `hypr/hyprland.conf` take effect immediately without a rebuild.

### Astal shell (`astal/`)

A standalone TypeScript/AGS project with its own `flake.nix`. Widgets live in `astal/widgets/`, styles in `astal/scss/`, themes in `astal/themes/`. Run it independently:

```bash
cd astal
nix run         # build and run
nix develop     # enter dev shell, then: ags run app.ts
```

### Caelestia shell

The active desktop shell, pulled in via the `caelestia-shell` flake input. Configured through `nixos/configuration/dotfiles/caelestia.nix` using `programs.caelestia` home-manager options provided by the flake's `homeManagerModules.default`.

### Flake templates (`nixos/flake_templates/`)

Reusable dev-shell templates for new projects: `standard.nix`, `python.nix`, `cpp.nix`.

## Key patterns

- **Adding a new system service**: create a module in `nixos/modules/`, import it in `nixos/modules/default.nix`.
- **Adding a new dotfile/app config**: create a module in `nixos/configuration/dotfiles/`, import it in `nixos/configuration/home.nix`.
- **Toggling features**: several imports are commented out in `home.nix` and `modules/default.nix` (e.g., zsh, zen). Uncomment to enable.
- **Nix formatter**: `nixfmt` is installed as a user package — use it to format `.nix` files.
