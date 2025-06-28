#!/bin/bash
# Set a robust PATH directly within the script
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH

# Define the path to your AppImage
APPIMAGE_PATH="/usr/local/bin/CoolerControl.AppImage" # <--- Confirm this path is correct!

# Logging function (keep this for now, it's very helpful)
log_message() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - coolercontrol-daemon-wrapper: $1" >> /var/log/coolercontrol-daemon.log
}

log_message "Wrapper script started. PID: $$"
log_message "Current PATH: $PATH"
log_message "AppImage path: $APPIMAGE_PATH"

# Ensure the AppImage is executable
chmod +x "$APPIMAGE_PATH"
if [ $? -ne 0 ]; then
    log_message "ERROR: Failed to make AppImage executable. Exit code $?."
    exit 1
fi
log_message "AppImage permissions checked."

# Check if AppImage exists
if [ ! -f "$APPIMAGE_PATH" ]; then
    log_message "ERROR: AppImage not found at $APPIMAGE_PATH. Exit code 1."
    exit 1
fi
log_message "AppImage file existence confirmed."

log_message "Attempting to execute AppImage: $APPIMAGE_PATH"
# Using 'exec' to replace the current shell process with the AppImage process
# REMOVE THE '--no-sandbox' ARGUMENT HERE!
exec "$APPIMAGE_PATH"
# If the above exec command failed
log_message "ERROR: Exec failed to launch AppImage. This line should not be reached if exec succeeded. Exit code 1."
exit 1


