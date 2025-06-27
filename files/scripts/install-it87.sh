#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

echo "--- Building and installing IT87 driver via DKMS ---"

    # Create a secure and unique temporary directory for cloning the driver source.
    # This ensures a clean workspace for the build process.
    IT87_TEMP_DIR=$(mktemp -d -t it87-XXXXXX)
    echo "Cloning IT87 driver into $IT87_TEMP_DIR..."
    git clone https://github.com/frankcrawford/it87 "$IT87_TEMP_DIR"
    cd "$IT87_TEMP_DIR"

    # Add the IT87 module source to the DKMS tree.
    # The 'it87/1.0' refers to the PACKAGE_NAME and PACKAGE_VERSION specified in the dkms.conf
    # file within the driver's repository. This step registers the module with DKMS.
    echo "Adding IT87 driver to DKMS tree..."
    sudo dkms add it87/1.0

    # Build and install the module for the currently active kernel.
    # DKMS will handle the compilation and installation. Crucially, it will
    # automatically rebuild and reinstall this module whenever a new kernel
    # version is installed on your system, maintaining compatibility.
    echo "Building and installing IT87 driver via DKMS..."
    sudo dkms install it87/1.0

    # Clean up the temporary directory after the installation is complete.
    echo "Cleaning up temporary directory: $IT87_TEMP_DIR"
    rm -rf "$IT87_TEMP_DIR"

    echo "--- IT87 driver installation complete ---"
