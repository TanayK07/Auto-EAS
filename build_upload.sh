#!/bin/bash

# Function to display options and get user input
choose_option() {
    echo "Select Platform:"
    echo "1) android"
    echo "2) ios"
    echo "3) all"
    read -rp "Enter choice (default: 1): " PLATFORM_CHOICE

    case $PLATFORM_CHOICE in
        1)
            PLATFORM="android"
            ;;
        2)
            PLATFORM="ios"
            ;;
        3)
            PLATFORM="all"
            ;;
        *)
            PLATFORM="android"
            ;;
    esac

    echo "Select Profile:"
    echo "1) development"
    echo "2) production"
    read -rp "Enter choice (default: 1): " PROFILE_CHOICE

    case $PROFILE_CHOICE in
        1)
            PROFILE="development"
            ;;
        2)
            PROFILE="production"
            ;;
        *)
            PROFILE="development"
            ;;
    esac
}

# Function to get the latest APK by sorting
get_latest_apk() {
    LATEST_APK=$(ls -t *.apk 2>/dev/null | head -n 1)
    if [ -z "$LATEST_APK" ]; then
        echo "No APK files found in the directory."
        exit 1
    fi
}

# Main script
run_build_and_upload() {
    # Navigate to the project directory
    cd /mnt/c/Users/ASUS/Valet_App || exit

    # Choose platform and profile
    choose_option

    # Run the build command
    echo "Starting the EAS build..."
    if eas build --local --profile "$PROFILE" --platform "$PLATFORM"; then
        echo "Build completed successfully."

        # Get the latest APK
        get_latest_apk
        echo "Found latest APK: $LATEST_APK"

        # Rename the latest APK
        TIMESTAMP=$(date +%Y%m%d-%H%M%S)
        RENAMED_APK="${PLATFORM}_${PROFILE}_${TIMESTAMP}.apk"
        mv "$LATEST_APK" "$RENAMED_APK"
        echo "Renamed APK to $RENAMED_APK"

        # Upload to Google Drive
        GOOGLE_DRIVE_FOLDER="APK"
        echo "Uploading $RENAMED_APK to Google Drive folder: $GOOGLE_DRIVE_FOLDER"
        rclone copy "$RENAMED_APK" valet-drive:/"$GOOGLE_DRIVE_FOLDER"

        if [ $? -eq 0 ]; then
            echo "APK uploaded successfully to Google Drive."
        else
            echo "Failed to upload APK to Google Drive."
        fi
    else
        echo "Build failed. Exiting script."
        exit 1
    fi
}

# Run the script
run_build_and_upload
