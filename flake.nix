{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };
  outputs = { self, nixos-hardware, nixpkgs }: {
    nixosModules.main-config = import ./configuration.nix;
    nixosConfigurations.raspberry-pi = nixpkgs.lib.nixosSystem {
      system = "aarch65";
      specialArgs = { inherit nixpkgs; };
      modules = [
        self.nixosModules.main-config
        nixos-hardware.nixosModules.raspberry-pi-4
      ];
    };
    nixosConfigurations.raspberry-pi-sdImage = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = { inherit nixpkgs; };
      modules = [
        self.nixosModules.main-config
        nixos-hardware.nixosModules.raspberry-pi-4
        "${nixpkgs}/nixos/modules/installer/sd-card/sd-image.nix"
        ./bootloader.nix
      ];
    };
  };
}
