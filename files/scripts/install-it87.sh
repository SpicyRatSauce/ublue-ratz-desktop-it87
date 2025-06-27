#!/usr/bin/env bash
# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

echo "--- Building and installing IT87 driver via DKMS ---"

    IT87_DKMS_SRC_DIR="/usr/src/it87-1.0"

    TEMP_CLONE_DIR=$(mktemp -d -t it87-clone-XXXXXX)
    echo "Cloning IT87 driver into temporary directory: $TEMP_CLONE_DIR..."
    git clone https://github.com/frankcrawford/it87 "$TEMP_CLONE_DIR"

    echo "Creating DKMS source directory: $IT87_DKMS_SRC_DIR"
    sudo mkdir -p "$IT87_DKMS_SRC_DIR"

    echo "Moving IT87 driver source to $IT87_DKMS_SRC_DIR..."
    sudo mv "$TEMP_CLONE_DIR"/* "$IT87_DKMS_SRC_DIR"/
    sudo mv "$TEMP_CLONE_DIR"/.git "$IT87_DKMS_SRC_DIR"/

    echo "Cleaning up temporary clone directory: $TEMP_CLONE_DIR"
    rm -rf "$TEMP_CLONE_DIR"

    echo "Adding IT87 driver to DKMS tree..."
    sudo dkms add it87/1.0

    echo "Building and installing IT87 driver via DKMS..."
    sudo dkms install it87/1.0

    echo "--- Configuring IT87 module options and autoload ---"

    # Add kernel module options for ignore_resource_conflict and force_id.
    # These will be applied when the module loads at boot.
    echo "options it87 ignore_resource_conflict=true force_id=0x8628" | sudo tee /etc/modprobe.d/it87.conf

    # Ensure the it87 module is loaded automatically at boot.
    echo "it87" | sudo tee /etc/modules-load.d/it87.conf

    # The following modprobe is only for testing during the build.
    # On a live system, the /etc/modprobe.d and /etc/modules-load.d
    # files will handle automatic loading with parameters.
    echo "Loading it87 module with force_id=0x8628 for build-time verification..."
    sudo modprobe it87 force_id=0x8628

    echo "--- IT87 driver installation and configuration complete ---"" | sudo tee /etc/modules-load.d/it87.conf

    # The following modprobe is only for testing during the build.
    # On a live system, the /etc/modprobe.d and /etc/modules-load.d
    # files will handle automatic loading with parameters.
    echo "Loading it87 module with force_id=0x8628 for build-time verification..."
    sudo modprobe it87 force_id=0x8628

    echo "--- IT87 driver installation and configuration complete ---"
