# Function to check if Git is installed
function Check-Git {
    $gitPath = (Get-Command git -ErrorAction SilentlyContinue).Path
    if (-not $gitPath) {
        Write-Host "Git is not installed. Installing Git..."
        Install-Git
    } else {
        Write-Host "Git is already installed."
    }
}

# Function to install Git
function Install-Git {
    $gitInstallerUrl = "https://github.com/git-for-windows/git/releases/download/v2.33.0.windows.1/Git-2.33.0-64-bit.exe"
    $gitInstallerPath = "$env:TEMP\Git-Installer.exe"
    
    # Download the Git installer
    Invoke-WebRequest -Uri $gitInstallerUrl -OutFile $gitInstallerPath
    
    # Install Git silently
    Start-Process -FilePath $gitInstallerPath -ArgumentList "/VERYSILENT", "/NORESTART" -Wait
    
    # Clean up the installer
    Remove-Item -Path $gitInstallerPath -Force
    
    Write-Host "Git installation completed."
}

# Check and install Git if necessary
Check-Git

# Define the temporary location for cloning the repository
$tempCloneDirectory = "C:\temp\WinltsAct"

# Define the destination folder where you want to copy the folders
$destinationFolder = "C:\Windows\System32\spp\tokens\skus"

# GitHub repository URL 
$repoUrl = "https://github.com/deadproject/WinltsAct.git"

# Make sure the destination folder exists
if (-Not (Test-Path -Path $destinationFolder)) {
    Write-Host "Creating directory: $destinationFolder"
    New-Item -Path $destinationFolder -ItemType Directory -Force
}

# Clone the repository to the temporary location
Write-Host "Cloning the repository to temporary location..."
git clone $repoUrl $tempCloneDirectory

# Define the source directories for the specific folders 
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

Write-Host "Windows Enterprise IoT LTSC activation completed"
