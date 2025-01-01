
# **Automated Build and Upload Script for EAS and Google Drive**

This project provides a Bash script to automate the process of building an app using `eas build`, renaming the generated APK, and uploading it to Google Drive. It is customizable and supports multiple platforms (`android`, `ios`, or `all`) and build profiles (`development`, `production`). The script simplifies repetitive tasks and ensures consistency in APK naming and storage.

---

## **Features**
- Fully automated `eas build` execution for `android` and `ios`.
- Dynamic APK renaming based on platform, profile, and timestamp.
- Seamless upload of the renamed APK to Google Drive using `rclone`.
- Configurable options for Google Drive API integration.
- Easy customization for different folder structures or build requirements.

---

## **Prerequisites**
Before running the script, ensure you have the following installed:

### **1. Required Tools**
- **[Node.js](https://nodejs.org/):** To use `eas-cli`.
- **[EAS CLI](https://docs.expo.dev/eas/cli/):** To handle builds.
- **[rclone](https://rclone.org/):** To interact with Google Drive.

### **2. Configure Google Drive API**
Follow the steps below to set up Google Drive API credentials:

1. Visit the **[Google Cloud Console](https://console.cloud.google.com/)**.
2. Create a new project (or use an existing one).
3. Enable the **Google Drive API** for your project.
4. Create OAuth 2.0 credentials (Client ID and Secret):
   - Go to **APIs & Services > Credentials**.
   - Click **Create Credentials > OAuth Client ID**.
   - Download the JSON credentials file.
5. Follow [this guide](https://rclone.org/drive/#making-your-own-client-id) to integrate the Client ID and Secret into `rclone`.

---

## **Setting Up the Script**

### **1. Clone This Repository**
Clone the repository and navigate to the project directory:
```bash
git clone https://github.com/your-username/automated-build-upload.git
cd automated-build-upload
```

### **2. Edit the Script**
Open the script file (`build_upload.sh`) in your preferred editor and make any necessary changes:

- **Google Drive Folder**: Update the target folder name in Google Drive:
  ```bash
  GOOGLE_DRIVE_FOLDER="YourFolderName"
  ```

- **rclone Remote Name**: If you named your `rclone` remote something other than `valet-drive`, update the script:
  ```bash
  rclone copy "$RENAMED_APK" your-remote-name:/YourFolderName
  ```

### **3. Make the Script Executable**
Set the appropriate permissions to make the script executable:
```bash
chmod +x build_upload.sh
```

---

## **Using the Script**

### **1. Run the Script**
Execute the script from the terminal:
```bash
./build_upload.sh
```

### **2. Follow the Prompts**
The script will ask you to select:
- **Platform**: Choose `android`, `ios`, or `all`.
- **Build Profile**: Choose `development` or `production`.

### **3. Workflow**
The script performs the following tasks:
1. Executes the `eas build` command based on your input.
2. Identifies the latest `.apk` file in the directory.
3. Renames the APK using the format:  
   `platform_profile_TIMESTAMP.apk` (e.g., `android_dev_20250101-143000.apk`).
4. Uploads the renamed APK to the specified Google Drive folder.

---

## **Script Customization**

### **1. Modify Build Parameters**
Update the `eas build` command if you need additional options:
```bash
eas build --local --profile "$PROFILE" --platform "$PLATFORM" --your-custom-flags
```

### **2. Email Notifications**
To receive notifications after each build, integrate email commands like `mailx` or use services like SendGrid.

### **3. Error Handling**
Enhance error handling by adding more checks (e.g., for missing files or invalid inputs).

---

## **Google Drive Configuration with rclone**

### **Setting Up rclone**
1. Install `rclone`:
   ```bash
   sudo apt install rclone
   ```

2. Configure your Google Drive remote:
   ```bash
   rclone config
   ```
   - Follow the prompts to authenticate with your Google account.
   - Use your custom Client ID and Secret for better API quotas ([guide here](https://rclone.org/drive/#making-your-own-client-id)).

3. Test the configuration:
   ```bash
   rclone lsd your-remote-name:
   ```
   This should list your Google Drive folders.

---

## **Project Structure**
```bash
automated-build-upload/
├── build_upload.sh       # Main automation script
├── README.md             # Documentation
└── LICENSE               # License file
```

---

## **Contributing**

We welcome contributions to improve this project. Here's how you can help:

1. Fork the repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add feature-name"
   ```
4. Push to your branch:
   ```bash
   git push origin feature-name
   ```
5. Open a pull request.

---

## **License**
This project is licensed under the MIT License. See the `LICENSE` file for details.
