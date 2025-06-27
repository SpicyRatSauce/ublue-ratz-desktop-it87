#!/usr/bin/env bash
# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Define the GitHub repository details
        IT87_REPO="https://github.com/frankcrawford/it87.git"
        BUILD_DIR="/tmp/it87-driver" # Temporary directory for cloning and building

        # Clone the repository
        git clone "${IT87_REPO}" "${BUILD_DIR}"

        # Change to the cloned directory
        cd "${BUILD_DIR}"

        # Execute the dkms-install.sh script
        # This script handles the 'make dkms' command internally,
        # which will perform dkms add, build, and install.
        # We need to run it with sudo because it performs system-level operations,
        # and the BlueBuild environment has root privileges.
        sudo ./dkms-install.sh

        # Optional: Clean up cloned repo if you want to save space in the final image
        # rm -rf "${BUILD_DIR}"

    # Add kernel module options for ignore_resource_conflict and force_id.
    # These will be applied when the module loads at boot.
    echo "options it87 ignore_resource_conflict=true force_id=0x8628" | sudo tee /etc/modprobe.d/it87.conf

    # Ensure the it87 module is loaded automatically at boot.
    echo "it87" | sudo tee /etc/modules-load.d/it87.conf


