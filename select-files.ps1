Clear-Host

# 1. Ask for the folder path
$root = (Read-Host "Enter the root folder path").Trim('"')
if (-not (Test-Path $root)) {
    Write-Host "Folder does not exist"
    exit
}

# 2. Get all folders (exclude junk)
$folders = Get-ChildItem -Path $root -Directory -Recurse -ErrorAction SilentlyContinue |
           Where-Object { $_.FullName -notmatch "node_modules|\.git" } |
           Select-Object FullName

# 3. Show GUI picker
# IMPORTANT: You must click/highlight rows in the popup window before clicking OK!
$selected = $folders |
    Out-GridView -Title "Select folders (Ctrl+A to select all, or Ctrl+Click for specific)" -PassThru

if (-not $selected) {
    Write-Host "No folders selected"
    exit
}

# 4. FIX: Filter out child folders if their parent is already selected
$sortedPaths = $selected.FullName | Sort-Object Length 
$finalPaths = @()

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

# 5. Collect files inside the filtered folders
$files = foreach ($folder in $finalPaths) {
    Get-ChildItem -Path $folder -File -Recurse -ErrorAction SilentlyContinue
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