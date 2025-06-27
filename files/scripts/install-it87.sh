#!/usr/bin/env bash
# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

echo "--- Building and installing IT87 driver via DKMS ---"

# Create a secure and unique temporary directory for cloning the driver source.
IT87_TEMP_DIR=$(mktemp -d -t it87-XXXXXX)
echo "Cloning IT87 driver into $IT87_TEMP_DIR..."
git clone https://github.com/frankcrawford/it87 "$IT87_TEMP_DIR"
cd "$IT87_TEMP_DIR"

# The original it87 dkms-install.sh uses 'make dkms' which handles
# dkms add, build, and install correctly, using the git describe version.
echo "Running 'make dkms' to add, build, and install the IT87 driver..."
# The Makefile from the it87 repo expects to be run from the root of the repo
# and then it manages the DKMS process.
sudo make dkms

echo "--- IT87 driver installation complete ---"

# Add kernel module options for ignore_resource_conflict and force_id.
echo "options it87 ignore_resource_conflict=true force_id=0x8628" | sudo tee /etc/modprobe.d/it87.conf

# Ensure the it87 module is loaded automatically at boot.
echo "it87" | sudo tee /etc/modules-load.d/it87.conf

# Clean up the temporary directory after the installation is complete.
echo "Cleaning up temporary directory: $IT87_TEMP_DIR"
rm -rf "$IT87_TEMP_DIR"


