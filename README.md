Recursive File Path Copier

A PowerShell script that lets you choose a root folder, select specific subfolders via a GUI, and copies the full paths of all files inside those folders to your clipboard. It intelligently excludes node_modules, .git, and child folders if their parent is already selected.

Installation & Setup

Save the Script
Save the PowerShell code as select-files.ps1 in a permanent location.

Create the Shortcut

Right-click Desktop -> New -> Shortcut.

For the location, use this format (update the path to match where you saved your file):

powershell.exe -ExecutionPolicy Bypass -File "D:\Your\Path\To\select-files.ps1"


Click Next, name it (e.g., "Select Files"), and click Finish.

Pin to Start Menu

Copy the shortcut you just created.

Press Win + R, paste the following path, and press Enter:

%AppData%\Microsoft\Windows\Start Menu\Programs


(Or manually navigate to: C:\Users\YOUR_USER\AppData\Roaming\Microsoft\Windows\Start Menu\Programs)

Paste the shortcut into this folder.

Open your Start Menu, search for the shortcut name, right-click it, and select Pin to Start.
