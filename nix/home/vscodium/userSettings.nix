{ lib }:

let
  jsons = [
    (builtins.fromJSON (builtins.readFile ./settings/base.json))
    (builtins.fromJSON (builtins.readFile ./settings/editor.json))
    (builtins.fromJSON (builtins.readFile ./settings/workbench.json))
    (builtins.fromJSON (builtins.readFile ./settings/explorer.json))
    (builtins.fromJSON (builtins.readFile ./settings/extensions.json))
    (builtins.fromJSON (builtins.readFile ./settings/formatters.json))
    (builtins.fromJSON (builtins.readFile ./settings/ssh.json))
    (builtins.fromJSON (builtins.readFile ./settings/terminal.json))
  ];

  merged =
    lib.foldl' lib.recursiveUpdate {} jsons;
in
builtins.toJSON merged
