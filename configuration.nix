{ config, lib, pkgs, ... }: {
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };
  networking = {
    hostName = "raspberry-pi";
    networkmanager.enable = true;
    wireless = {
      enable = true;
      networks.jackocktagon.psk = "gorgonzola";
      interfaces = [ "wlan0" ];
    };
  };
  hardware.raspberry-pi."4".fkms-3d.enable = true;
  users = {
    mutableUsers = false;
    users.anselmschueler = {
      isNormalUser = true;
      description = "Anselm Schüler";
      hashedPassword =
        "$y$j9T$MggYbRbZoK.1WEW96K1el0$hcbo3SFFwDbvI5BPV4GdW2jWTAR1fMd56ssqeSgb8r5";
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
}
