{ config, lib, pkgs, nixpkgs, ... }: {
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };
  networking = {
    hostName = "raspberry-pi";
    networkmanager.enable = true;
  };
  hardware.raspberry-pi."4".fkms-3d.enable = true;
  users = {
    mutableUsers = false;
    users.anselmschueler = {
      isNormalUser = true;
      description = "Anselm Schüler";
      hashedPassword =
        "$y$j9T$w4UFfIcumY8QU8eym.Pvy0$0uDwpo2jG7VwL8uXNi9S7sLUWpSvGGIkoqOo6UAD//2";
      extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBADVkv3VPlmMB5+251kdlVae/RnH6VLHIK756Y83/a2jMpMZH1D9Tqwl8H9WSkZUMpZDXf15zKvrmJid+MxAkWfSSwCCu58btaFAVa6iIK9Zm6bbWEk7FeF3gd2n5cvW2dki2PovBc2yFUpE2ao+90BhEtfwouU+rrVRru1zcyEkmvO5FA== mail@anselmschueler.com"
      ];
    };
  };
  programs.fish.enable = true;
  services = {
    openssh = {
      enable = true;
      passwordAuthentication = false;
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
    };
    xserver = {
      enable = true;
      displayManager.lightdm.enable = true;
      desktopManager.xfce.enable = true;
    };
  };
  system.stateVersion = "22.05";
  nix = {
    registry.nixpkgs.to = {
  owner = "NixOS";
  repo = "nixpkgs";
  rev = nixpkgs.sourceInfo.rev;
  type = "github";
};
nixPath = [ "nixpkgs=${nixpkgs}" ];
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = { auto-optimise-store = true; };
  };
}
