# WinltsAct

This script is for activating **Windows 10 Enterprise LTSC (Long-Term Servicing Channel)**. The LTSC version is designed for specific use cases that require a stable, long-term version of Windows without the frequent feature updates that are common in other versions of Windows 10.

## Contents

- **Activation Scripts**: Includes various scripts that can be used for activating Windows 10 Enterprise LTSC.

## Prerequisites

Before you can use any of the tools or methods provided in this repository, you must meet the following requirements:

- A valid **Windows 10 Enterprise LTSC** installation.
- Administrator privileges on your system to run activation scripts.

## Dev Team

- **Project/Deadproject** – Project Lead and Developer 
- **TMasser1** - Developer 
## 💡 Usage

WinltsAct must be run in Admin mode because it performs system-wide tweaks. To achieve this, run PowerShell as an administrator. Here are a few ways to do it:

1. **Start menu Method:**
   - Right-click on the start menu.
   - Choose "Windows PowerShell (Admin)" (for Windows 10) or "Terminal (Admin)" (for Windows 11).

2. **Search and Launch Method:**
   - Press the Windows key.
   - Type "PowerShell" or "Terminal" (for Windows 11).
   - Press `Ctrl + Shift + Enter` or Right-click and choose "Run as administrator" to launch it with administrator privileges.

### Launch Command

```ps1
irm "https://github.com/deadproject/WinltsAct/raw/main/winltsact.ps1" | iex
```

If you have Issues, refer to [Known Issues](https://github.com/deadproject/WinAct/issues)
