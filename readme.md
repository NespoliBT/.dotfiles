# Nixos + Hyprland + Astal

#### I spent way too much time getting this setup to work.

![](./assets/astal-hyprland.gif)
Theoretically, settings this up on NixOS should be as easy as running the following command:

```bash
sudo nixos-rebuild switch --flake ~/.dotfiles/nixos#nespoli
```
## ✨ What is going on?
This config is based on the following:
- [NixOS](https://nixos.org/)
- [Hyprland](https://hyprland.org/)
- [Astal](https://github.com/Aylur/Astal)

The main premise of this setup is to have NixOS manage everything. Obviously, I have no idea what I'm doing.

## 👀 Structure
This is probably going to change.

### ./astal/
This is where the Astal config lives. Basically this manager all the widgets, the fancy stuff on the screen. I dont really use it but it's super fun to develop. Running this should be as simple as running `nix run` or entering the dev shell with `nix develop` and then running `ags run app.ts`

### ./hypr/
The window managing. Not much to say here. I use the default config with some tweaks.

### ./nixos/
The fun part. I copied most of this from strangers on the internet. Basically the configuration starts from the `flake.nix` file. Here I import the system configuration and the modules I need. 

### ./nix/
The old config. I am scared of deleting it.

