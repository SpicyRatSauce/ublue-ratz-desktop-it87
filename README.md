# ublue-ratz-desktop-it87 &nbsp; [![bluebuild build badge](https://github.com/spicyratsauce/ublue-ratz-desktop-it87/actions/workflows/build.yml/badge.svg)](https://github.com/spicyratsauce/ublue-ratz-desktop-it87/actions/workflows/build.yml)


To rebase an existing atomic Fedora installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/spicyratsauce/ublue-ratz-desktop-it87:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/spicyratsauce/ublue-ratz-desktop-it87:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```
