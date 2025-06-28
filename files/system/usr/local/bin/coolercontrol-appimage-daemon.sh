#!/bin/bash

APPIMAGE_PATH="/usr/local/bin/coolercontrold.AppImage"
GITHUB_RELEASE_URL="https://gitlab.com/coolercontrol/coolercontrol/-/releases/permalink/latest/downloads/packages/CoolerControlD-x86_64.AppImage"
DESKTOP_FILE_NAME="CoolerControl Web UI.desktop" # Name for the .desktop file
WEB_UI_URL="http://localhost:11987" # The URL for the web UI

# --- AppImage Download and Execution Logic ---
# Check if the AppImage exists
if [ ! -f "$APPIMAGE_PATH" ]; then
    echo "coolercontrold.AppImage not found. Downloading..."
    # Create the directory if it doesn't exist
    sudo mkdir -p /usr/local/bin/
    # Download the AppImage
    sudo curl -L "$GITHUB_RELEASE_URL" -o "$APPIMAGE_PATH"
    if [ $? -ne 0 ]; then
        echo "Error downloading coolercontrold.AppImage. Exiting."
        exit 1
    fi
    echo "Download complete."
else
    echo "coolercontrold.AppImage already found."
fi

# Make the AppImage executable
if [ ! -x "$APPIMAGE_PATH" ]; then
    echo "Making coolercontrold.AppImage executable..."
    sudo chmod +x "$APPIMAGE_PATH"
    if [ $? -ne 0 ]; then
        echo "Error making coolercontrold.AppImage executable. Exiting."
        exit 1
    fi
    echo "AppImage is now executable."
else
    echo "coolercontrold.AppImage is already executable."
fi

echo "Launching coolercontrold.AppImage..."
# Launch the AppImage in the background
"$APPIMAGE_PATH" &

# --- .desktop File Creation Logic ---
# Find the Desktop directory for the first non-root user that has one
DESKTOP_DIR=""
for user_home in /home/*; do
    if [ -d "$user_home" ]; then
        # Check common desktop locations
        if [ -d "$user_home/Desktop" ]; then
            DESKTOP_DIR="$user_home/Desktop"
            break
        elif [ -d "$user_home/desktop" ]; then # Some systems use lowercase
            DESKTOP_DIR="$user_home/desktop"
            break
        fi
    fi
done

if [ -z "$DESKTOP_DIR" ]; then
    echo "Warning: Could not find a user's Desktop directory. The .desktop file will not be created."
else
    DESKTOP_FILE_PATH="$DESKTOP_DIR/$DESKTOP_FILE_NAME"

    # Create the .desktop file content
    echo "[Desktop Entry]" > "$DESKTOP_FILE_PATH"
    echo "Version=1.0" >> "$DESKTOP_FILE_PATH"
    echo "Type=Application" >> "$DESKTOP_FILE_PATH"
    echo "Terminal=false" >> "$DESKTOP_FILE_PATH" # Set to true if you want a terminal to pop up
    echo "Exec=xdg-open $WEB_UI_URL" >> "$DESKTOP_FILE_PATH"
    echo "Name=CoolerControl Web UI" >> "$DESKTOP_FILE_PATH"
    echo "Comment=Open CoolerControl Web Interface" >> "$DESKTOP_FILE_PATH"
    echo "Icon=web" >> "$DESKTOP_FILE_PATH" # You can use a specific icon name or path

    # Make the .desktop file executable
    chmod +x "$DESKTOP_FILE_PATH"
    chown $(basename "$user_home"):$(basename "$user_home") "$DESKTOP_FILE_PATH" # Set owner to the user

    echo "Created .desktop file: $DESKTOP_FILE_PATH"
fi

echo "Script finished."
