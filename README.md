# 🖥️ Wim File Script

## ⚠️ Experimental Notice

**Warning:** This script is currently in an experimental phase and may contain errors. It is subject to changes and updates. Please report any issues or provide suggestions for improvements.

## Overview

🔧 This script provides a user-friendly interface to decompile and compile Windows Imaging Format (WIM) files using DISM.

## Features

- **Decompile**: Extracts content from `*.wim` and mounts it for modification.
- **Compile**: Captures modified content into a new `.wim` file.
- **User Interaction**: Utilizes PowerShell dialogs for file and folder selection.
- **Administrative Permissions**: Requires administrator rights to run due to DISM requirements.

## Usage

1. **Decompile `*.wim`**:
   - Select option 1 to decompile `*.wim` and mount it at `C:\mount` for modifications.

2. **Compile to a new `.wim` file**:
   - After making modifications in `C:\mount`, select option 2 to compile the content into a new `.wim` file.

## Requirements

- Windows operating system with DISM (Deployment Image Servicing and Management) tool installed.
- PowerShell for file and folder selection dialogs (comes pre-installed with Windows).

## Usage Notes

- Ensure to run the script with administrative privileges.
- Customize and use responsibly as per your requirements.

## License

📜 This script is licensed under the MIT License. See LICENSE.txt for more details.
