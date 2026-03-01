{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} ({
      self,
      withSystem,
      ...
    }: {
      imports = [
        ./packages
        ./module.nix
      ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      flake = {
        overlays = {
          anchorr = _final: prev:
            withSystem prev.stdenv.hostPlatform.system (
              {config, ...}: {
                inherit (config.packages) anchorr;
              }
            );
          default = self.overlays.anchorr;
        };
      };
    });
}
