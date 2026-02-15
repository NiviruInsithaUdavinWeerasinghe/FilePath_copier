Clear-Host

# 1. Ask for the folder path
$root = (Read-Host "Enter the root folder path").Trim('"')
if (-not (Test-Path $root)) {
    Write-Host "Folder does not exist"
    exit
}

# Ask to include files directly in the root folder
$includeRoot = Read-Host "Do you want to copy files directly in the main folder too? (Y/N)"

# 2. Get all folders (exclude junk)
$folders = Get-ChildItem -Path $root -Directory -Recurse -ErrorAction SilentlyContinue |
           Where-Object { $_.FullName -notmatch "node_modules|\.git" } |
           Select-Object FullName

# 3. Show GUI picker
# IMPORTANT: You must click/highlight rows in the popup window before clicking OK!
$selected = $folders |
    Out-GridView -Title "Select folders (Ctrl+A to select all, or Ctrl+Click for specific)" -PassThru

if (-not $selected -and $includeRoot -notmatch "^[Yy]$") {
    Write-Host "No folders selected and root folder skipped"
    exit
}

# 4. FIX: Filter out child folders if their parent is already selected
$finalPaths = @()
if ($selected) {
    $sortedPaths = $selected.FullName | Sort-Object Length 
    foreach ($path in $sortedPaths) {
        $isCovered = $false
        foreach ($parent in $finalPaths) {
            # If the current path starts with "ParentPath\", it's inside that parent
            if ($path.StartsWith("$parent\")) {
                $isCovered = $true
                break
            }
        }
        if (-not $isCovered) {
            $finalPaths += $path
        }
    }
}

# 5. Collect files inside the filtered folders
$files = @()

# Add files directly inside the root folder (not recursive) if user said Yes
if ($includeRoot -match "^[Yy]$") {
    $files += Get-ChildItem -Path $root -File -ErrorAction SilentlyContinue
}

# Add files from the selected subfolders (recursive)
if ($finalPaths.Count -gt 0) {
    $files += foreach ($folder in $finalPaths) {
        Get-ChildItem -Path $folder -File -Recurse -ErrorAction SilentlyContinue
    }
}

if (-not $files) {
    Write-Host "No files found to copy."
    exit
}

# 6. Copy to clipboard
$paths = $files.FullName | Sort-Object -Unique
$paths | Set-Clipboard

Write-Host ""
Write-Host "========================================="
Write-Host "Total files copied:" $paths.Count
Write-Host "========================================="
Write-Host "Full file paths copied to clipboard"
Pause
