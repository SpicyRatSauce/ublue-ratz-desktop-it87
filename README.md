# ublue-ratz-desktop-it87 &nbsp; [![bluebuild build badge](https://github.com/spicyratsauce/ublue-ratz-desktop-it87/actions/workflows/build.yml/badge.svg)](https://github.com/spicyratsauce/ublue-ratz-desktop-it87/actions/workflows/build.yml)

## KDE Ublue Distro With it87 built in for Desktops.

## Installing CoolerControl

1. Download CoolerControl Appimage from `https://docs.coolercontrol.org/installation/appimage.html` and rename to `CoolerControl.AppImage` and `coolercontrol-appimage-daemon.sh` from this github.

2. Set executable: `chmod +x CoolerControl.AppImage` and `chmod +x coolercontrol-appimage-daemon.sh`.

4. Copy both to `/usr/local/bin`: `sudo cp CoolerControl.AppImage /usr/local/bin` & `sudo cp coolercontrol-appimage-daemon.sh /usr/local/bin`.

5. Create `coolercontrold.service` at `/etc/systemd/system/` with contents:
```
[Service]
Type=simple

ExecStart=/usr/local/bin/coolercontrol-appimage-daemon.sh
Restart=on-failure
RestartSec=5s
User=root
Group=root

# Disabled for now
# ProtectSystem=full
# ProtectHome=true
# PrivateTmp=true
# NoNewPrivileges=true
# CapabilityBoundingSet=CAP_SYS_RAWIO CAP_DAC_OVERRIDE

StandardOutput=journal # Ensure all output goes to journal
StandardError=journal
```

6. Enable service `sudo systemctl enable --now coolercontrold.service`.
