{
  perSystem = {
    config,
    pkgs,
    ...
  }: {
    packages.anchorr = pkgs.callPackage ./anchorr.nix {};
    packages.default = config.packages.anchorr;
  };
}
