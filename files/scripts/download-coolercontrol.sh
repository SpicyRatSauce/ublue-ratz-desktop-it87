#!/usr/bin/env bash
        set -euo pipefail

        COOLERCONTROL_VERSION="2.2.1" # Ensure this matches the desired release
        DOWNLOAD_BASE="https://gitlab.com/coolercontrol/coolercontrol/-/releases/${COOLERCONTROL_VERSION}/downloads/packages"

        # Download CoolerControl Daemon
        curl -L "${DOWNLOAD_BASE}/coolercontrold_${COOLERCONTROL_VERSION}" -o /usr/local/bin/coolercontrold
        chmod +x /usr/local/bin/coolercontrold

        # Download CoolerControl Desktop Application
        curl -L "${DOWNLOAD_BASE}/coolercontrol_${COOLERCONTROL_VERSION}" -o /usr/local/bin/coolercontrol-gui # Rename to avoid conflict if you later install the rpm
        chmod +x /usr/local/bin/coolercontrol-gui

