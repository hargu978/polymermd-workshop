# Installing WSL (Windows Subsystem for Linux) and Opening Ubuntu Terminal

*Author: Harish Gudla (harish@comulartech.com)*  
*Date: 2025-12-10*

This document provides a step-by-step guide for Windows users to install and configure the Windows Subsystem for Linux (WSL) and Ubuntu. It includes prerequisites, installation steps, basic bash commands, and instructions for uninstalling WSL and Ubuntu if needed. This guide is especially helpful for developers and users who want to use Linux tools and commands on a Windows system.

## Table of Contents
- [Enable WSL](#enable-wsl)
- [Reboot Your System](#reboot-your-system)
- [Download and Install Ubuntu](#download-and-install-ubuntu)
- [Start Ubuntu Terminal](#start-ubuntu-terminal)
- [Basic Bash Commands](#basic-bash-commands)
- [Uninstall WSL and Ubuntu](#uninstall-wsl-and-ubuntu)

## Prerequisites
Before proceeding with the installation, ensure your system meets the following requirements:
- **Minimum Disk Space**: 5 GB of free disk space.
- **Recommended CPU Cores**: At least 2 cores.
- **Recommended RAM**: 4 GB or more.
- **Estimated Installation Time**: Approximately 15-20 minutes, depending on system performance and internet speed.

## Enable WSL
1. Open **Windows PowerShell** as Administrator.  
   - **Estimated Time**: Less than 1 minute.
2. Run the following command to enable WSL:
   ```bash
   wsl --install
   ```
   - **Estimated Time**: 5-10 minutes, depending on your system's performance.
3. Once installation is finished you should see these lines at the end:
   ```text
   Enabling feature(s)
   [==========================100.0%==========================]
   The operation completed successfully.
   The requested operation is successful. Changes will not be effective until the system is rebooted.
   ```

## Reboot Your System
1. Save all your work and close any open applications.
2. Restart your system by:
   - Clicking on the **Start Menu**.
   - Selecting **Power** and then **Restart**.
   - **Estimated Time**: 2-5 minutes.

## Download and Install Ubuntu
1. Open the **Microsoft Store** from the **Start Menu**.
2. Search for **Ubuntu** in the store's search bar.
3. Select your preferred version of Ubuntu (e.g., Ubuntu 20.04 LTS) and click **Get** or **Install**.
   - **Estimated Time**: 5-10 minutes, depending on your internet speed.
4. Wait for the download and installation to complete.

## Start Ubuntu Terminal
1. After the installation, open the **Start Menu**.
2. Search for **Ubuntu** in the search bar.
3. Click on the **Ubuntu** app to launch the terminal.
4. Follow the on-screen instructions to complete the initial setup, such as creating a username and password.
   - Example username: **ubuntu**
   - **Estimated Time**: 2-3 minutes.

![alt text](ubuntu-success.png)

5. Update the package lists to ensure you have the latest information about available packages:
   ```bash
   sudo apt update
   ```
   - **Estimated Time**: 1-2 minutes.

You can find the Windows Documents folder like this:
```bash
cd /mnt/c/Users/YOUR_USERNAME/Documents/
```

## Basic Bash Commands
Here are some basic bash commands to get started, along with examples:

1. **List files in the current directory**:
   ```bash
   ls
   ```
   Example:
   ```bash
   ubuntu@MACHINENAME:~$ ls
   Documents  Downloads  Pictures
   ```

2. **Print the current working directory**:
   ```bash
   pwd
   ```
   Example:
   ```bash
   ubuntu@MACHINENAME:~$ pwd
   /home/ubuntu
   ```

3. **Change directory**:
   ```bash
   cd <directory_path>
   ```
   Example:
   ```bash
   cd Documents
   ```

4. **Create a new directory**:
   ```bash
   mkdir <directory_name>
   ```
   Example:
   ```bash
   mkdir new_folder
   ```

5. **View the contents of a file**:
   ```bash
   cat <file_name>
   ```
   Example:
   ```bash
   cat example.txt
   ```

6. **Copy a file**:
   ```bash
   cp <source_file> <destination_file>
   ```
   Example:
   ```bash
   cp file1.txt file2.txt
   ```

7. **Move or rename a file**:
   ```bash
   mv <source_file> <destination_file>
   ```
   Example:
   ```bash
   mv old_name.txt new_name.txt
   ```

8. **Remove a file**:
   ```bash
   rm <file_name>
   ```
   Example:
   ```bash
   rm unwanted_file.txt
   ```

## Uninstall WSL and Ubuntu

### Uninstall Ubuntu
1. Open the **Start Menu** and search for **Apps & features**.
2. In the **Apps & features** window, search for **Ubuntu** in the search bar.
3. Select the installed Ubuntu version (e.g., Ubuntu 20.04 LTS) and click **Uninstall**.
4. Confirm the uninstallation when prompted.

### Uninstall WSL
1. Open **Windows PowerShell** as Administrator.
2. Disable the WSL feature by running the following command:
   ```bash
   dism.exe /online /disable-feature /featurename:Microsoft-Windows-Subsystem-Linux /norestart
   ```
3. If you also want to remove the Virtual Machine Platform, run:
   ```bash
   dism.exe /online /disable-feature /featurename:VirtualMachinePlatform /norestart
   ```
4. Restart your system to complete the uninstallation process.

### Remove WSL Files
1. Navigate to the WSL installation folder (usually located at `C:\Users\<YourUsername>\AppData\Local\Packages`).
2. Delete the folder corresponding to your Ubuntu installation (e.g., `CanonicalGroupLimited.Ubuntu20.04onWindows`).

> **Note**: Uninstalling WSL and Ubuntu will delete all associated files and data. Ensure you back up any important data before proceeding.
