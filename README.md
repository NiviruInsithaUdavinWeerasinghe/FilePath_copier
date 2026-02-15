# 📂 File Path Selector Tool

**A PowerShell utility to bulk-select folders via a GUI and instantly copy all file paths to your clipboard.**

> **⚠️ WARNING:** Be careful when selecting folders that contain a massive amount of files (like an entire drive). Selecting hundreds of thousands of files at once can overload your system's memory, causing the script to freeze or your computer to crash.

---

## 🚀 How to Setup & Pin to Start

### 1. Save the Script
Save the `select-files.ps1` file to a permanent location where you won't delete it (e.g., `C:\Scripts\` or your Documents folder).

### 2. Create the Shortcut Directly in the Start Menu
This method creates the tool directly in your application list so it is ready to use immediately.

1.  Open the **Run** dialog (press `Win + R`).
2.  Paste the following path and press **Enter**:
    ```text
    %AppData%\Microsoft\Windows\Start Menu\Programs
    ```
3.  In the folder that opens, **Right-click > New > Shortcut**.
4.  In the location box, paste the code below (replace `"C:\Your\Path\To\select-files.ps1"` with the actual location where you saved the script):
    ```powershell
    powershell.exe -ExecutionPolicy Bypass -File "C:\Your\Path\To\select-files.ps1"
    ```
5.  Click **Next**, name it **"Select Files"**, and click **Finish**.

### 3. Change the Icon (Optional)
To make the tool look professional, you can replace the default PowerShell icon with a custom `.ico` file.

1.  In the folder where you just created the shortcut, **Right-click** the "Select Files" shortcut and select **Properties**.
2.  Go to the **Shortcut** tab and click the **Change Icon...** button.
    * *Note: If a warning appears saying the file contains no icons, just click OK.*
3.  Click **Browse** and locate your `.ico` file (or select a system icon).
4.  Select the icon, click **OK**, then click **Apply** and **OK**.

### 4. Pin to Start
The tool is now installed and styled. To make it even faster to access:
1.  Open your **Start Menu** and search for **"Select Files"**.
2.  Right-click the icon and select **Pin to Start**.

---

## 🛠 Features
* **Smart Filtering:** Automatically ignores heavy folders like `node_modules` and `.git`.
* **Visual Picker:** Opens a popup window (`Out-GridView`) where you can multi-select folders using `Ctrl + Click`.
* **Auto-Copy:** Instantly copies the full paths of all files inside selected folders to your clipboard.
