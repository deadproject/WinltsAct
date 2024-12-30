# Define the temporary location for cloning the repository
$tempCloneDirectory = "C:\temp\WinltsAct"

# Define the destination folder where you want to copy the folders
$destinationFolder = "C:\Windows\System32\spp\tokens\skus"

# GitHub repository URL (You will clone the entire repo)
$repoUrl = "https://github.com/deadproject/WinltsAct.git"

# Make sure the destination folder exists
if (-Not (Test-Path -Path $destinationFolder)) {
    Write-Host "Creating directory: $destinationFolder"
    New-Item -Path $destinationFolder -ItemType Directory -Force
}

# Clone the repository to the temporary location
Write-Host "Cloning the repository to temporary location..."
git clone $repoUrl $tempCloneDirectory

# Define the source directories for the specific folders you want to copy
$csvlkPackSourceFolder = "$tempCloneDirectory\csvlk-pack"
$enterpriseSSourceFolder = "$tempCloneDirectory\EnterpriseS"

# Copy the entire csvlk-pack folder to the destination
Write-Host "Copying csvlk-pack folder to the destination..."
Copy-Item -Path $csvlkPackSourceFolder -Destination $destinationFolder -Recurse -Force

# Copy the entire EnterpriseS folder to the destination
Write-Host "Copying EnterpriseS folder to the destination..."
Copy-Item -Path $enterpriseSSourceFolder -Destination $destinationFolder -Recurse -Force

# Clean up by removing the cloned repository
Write-Host "Cleaning up by removing the cloned repository..."
Remove-Item -Recurse -Force $tempCloneDirectory

# Execute slmgr commands for Windows activation
Write-Host "Executing slmgr commands..."

$slmgrCommands = @(
    "$env:windir\system32\slmgr.vbs /rilc",
    "$env:windir\system32\slmgr.vbs /upk >nul 2>&1",
    "$env:windir\system32\slmgr.vbs /ckms >nul 2>&1",
    "$env:windir\system32\slmgr.vbs /cpky >nul 2>&1",
    "$env:windir\system32\slmgr.vbs /ipk M7XTQ-FN8P6-TTKYV-9D4CC-J462D",
    "$env:windir\system32\slmgr.vbs /skms kms.digiboy.ir",
    "$env:windir\system32\slmgr.vbs /ato"
)

foreach ($command in $slmgrCommands) {
    Write-Host "Running: $command"
    Invoke-Expression $command
}

Write-Host "Windows activation completed."