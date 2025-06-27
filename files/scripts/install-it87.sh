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

<<<<<<< HEAD
    echo "--- IT87 driver installation complete ---"
=======
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
>>>>>>> 5fd58b5f82c0bbd45b41fc824d09a6ffdf7b7d84
