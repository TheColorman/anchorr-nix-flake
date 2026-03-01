# Anchorr nix flake

This repository contains a Nix flake for
[Anchorr](https://github.com/nairdahh/Anchorr).

## Usage

Add this repo to your flake inputs, and add the module to your NixOS
configuration:

```nix
{
inputs = {
        # ... other inputs such as nixpkgs
        anchorr.url = "github:TheColorman/anchorr-nix-flake";
        # Optionally follow your existing nixpkgs
        anchorr.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = {nixpkgs, anchorr, ...}: {
        nixosConfigurations.my-system = nixpkgs.lib.nixosSystem {
            modules = [
                ./configuration.nix
                anchorr.nixosModules.default
            ];
        };
    }
}
```

You can now configure Anchorr. Here is a list of all configuration options and
their defaults:

```nix
{
    services.anchorr = {
        # No instances are enabled by default, but you can add as many as you want here.
        my-instance = {
            enable = true; # Default: false
            name = "my-instance"; # Default: same as instance attribute name
            package = <package>; # Default: anchorr.packages.<system>.anchorr

            # Settings written to `config.json`. For all options, see
            # - https://github.com/nairdahh/Anchorr/blob/0875b285dca22e5943fa13428886f84c3303baed/lib/config.js
            settings = {};

            # Path to a JSON file that will be merged with the "settings" option, suitable for storing secrets.
            settingsFile = "/run/secrets/anchorr.json";
        };
    };
}
```

For more details on every option, see [./module.nix](./module.nix).
