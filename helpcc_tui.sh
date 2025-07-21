#!/bin/bash
set -euo pipefail  # Exit on error, undefined vars, pipe failures

#
# Help Command Center (HCC)
# A terminal-based interactive command reference tool
#
# Author: gnzo3e
# License: MIT
# Version: 1.1.0
#
# Description:
# This script provides an interactive TUI (Text User Interface) for accessing
# commonly used Linux commands and their explanations. It uses the 'dialog'
# utility to create a user-friendly interface with categorized command references.
# The script features a modular sub-menu structure for better performance and
# navigation, with focused dialog boxes for each command category.
#
# Features:
# - Modular sub-menu architecture for fast loading and better UX
# - Comprehensive command coverage with practical examples (25+ sub-menus)
# - Color-coded output for better readability and quick scanning
# - Robust error handling with automatic cleanup and signal trapping
# - Dependency checking and validation at startup
# - Optimized dialog box dimensions for various terminal sizes
# - Memory-efficient design with proper resource management
#
# Dependencies:
# - dialog: For creating the TUI interface (checked at runtime)
# - bash: Shell interpreter (version 4.0 or higher recommended)
# - Linux environment: Commands are Linux-specific
#
# Installation:
# 1. Ensure dialog is installed: sudo apt-get install dialog
# 2. Make script executable: chmod +x helpcc_tui.sh
# 3. Run the script: ./helpcc_tui.sh
# 4. Optional: Create alias for global access
#
# Usage:
# ./helpcc_tui.sh
#
# Navigation:
# - Use arrow keys to navigate menus
# - Press Enter to select an option
# - Press Escape or select "Back" to return to previous menu
# - Select "Exit" or press Ctrl+C to quit
# - Use Page Up/Down to scroll through long help content
#
# Performance Optimizations:
# - Sub-menus load only when accessed (lazy loading)
# - Optimized dialog box dimensions for faster rendering
# - Efficient string handling and minimal external calls
# - Proper resource cleanup and memory management
# - Signal trapping for clean exits and error recovery
#
# Main Categories:
# 1. Basic Commands - Organized into 4 sub-categories:
#    • Directory Navigation (pwd, ls, cd)
#    • File Operations (cp, mv, rm, cat)
#    • Shell Utilities (echo, man, history, PATH)
#    • System Information (uname -m, lsblk, lsb_release -a)
#
# 2. GPU Monitor - Split into 3 specialized sections:
#    • NVIDIA GPU Commands (nvidia-smi variants)
#    • AMD GPU Commands (rocm-smi variants)
#    • General GPU Tips (monitoring best practices)
#
# 3. Package Management - Comprehensive 6-section breakdown:
#    • System Update (apt update, upgrade, full-upgrade)
#    • Package Installation (install, reinstall)
#    • Package Removal (remove, purge, autoremove)
#    • Package Information (search, show, list)
#    • Package Maintenance (hold, clean, autoclean)
#    • Package Dependencies (depends, rdepends, history)
#
# 4. System Monitoring - 6 focused monitoring areas:
#    • System Overview (landscape-sysinfo, neofetch)
#    • Process Monitoring (htop, btop, top)
#    • Resource Monitoring (glances, free, df)
#    • Hardware Monitoring (sensors, lscpu, lshw)
#    • Network Monitoring (iftop, nethogs, ss)
#    • Performance Stats (vmstat, iostat, sar)
#
# 5. Network Commands - Network interface and configuration commands
#    • IP link management, netplan, NetworkManager tools
#
# 6. Git Commands - Organized into 6 workflow-based sections:
#    • Configuration (user setup, editor, defaults)
#    • Repository Setup (init, clone)
#    • Basic Operations (status, add, commit)
#    • Branch Management (branch, checkout, merge)
#    • Remote Operations (fetch, pull, push)
#    • History & Inspection (log, diff, show, stash)
#
# 7. Docker Commands - 4 comprehensive Docker sections:
#    • Container Management (ps, run, start, stop, rm)
#    • Image Management (images, pull, build, rmi, tag)
#    • Container Interaction (exec, logs, inspect, cp)
#    • System Management (system commands, cleanup)
#
# 8. User & Group Management - 6 comprehensive user administration sections:
#    • User Creation & Management (adduser, useradd, deluser)
#    • Group Creation & Management (addgroup, adduser to group)
#    • User Information & Listing (whoami, id, who, getent)
#    • Password & Security (passwd, chage, account locking)
#    • User Permissions & Sudo (sudo group, visudo, privileges)
#    • Advanced User Management (usermod, rename, shell change)
#
# Error Handling:
# - Dependency verification at startup with clear error messages
# - Graceful handling of dialog cancellation and user interruption
# - Automatic cleanup of temporary files with EXIT trap
# - Signal trapping for clean exits (SIGINT, SIGTERM)
# - Informative error messages with troubleshooting guidance
#
# Troubleshooting:
# - If dialog is missing: sudo apt-get install dialog
# - If colors don't display: ensure terminal supports ANSI colors
# - If slow performance: check terminal size (minimum 80×24)
# - For navigation issues: use keyboard (arrow keys, Enter, Escape)
# - Debug mode: bash -x ./helpcc_tui.sh
#
# Contributing:
# - Follow existing code structure and naming conventions
# - Test all menu paths before submitting changes
# - Update documentation when adding new categories or commands
# - Maintain consistent dialog box sizing (15-18 height, 50-75 width)
# - Include practical examples and clear explanations
# - Follow bash best practices and error handling patterns

# Global variables
TEMP_FILE=""
readonly SCRIPT_NAME="$(basename "$0")"
readonly VERSION="1.1.0"

# Initialize and check dependencies
init_script() {
    # Check if dialog is installed
    if ! command -v dialog &> /dev/null; then
        echo "Error: dialog is not installed. Please install it using:"
        echo "sudo apt-get install dialog"
        exit 1
    fi

    # Create a temporary file to store dialog output
    TEMP_FILE=$(mktemp) || {
        echo "Error: Cannot create temporary file"
        exit 1
    }

    # Set up cleanup trap
    trap cleanup EXIT INT TERM
}

# Cleanup function
cleanup() {
    [[ -n "$TEMP_FILE" && -f "$TEMP_FILE" ]] && rm -f "$TEMP_FILE"
    clear
}

# Function to display Basic commands sub-menu
show_basic_commands() {
    while true; do
        dialog --title "Basic Commands" \
               --menu "Select a subcategory:" 15 50 6 \
               1 "Directory Navigation" \
               2 "File Operations" \
               3 "Shell Utilities" \
               4 "System Information" \
               0 "Back to Main Menu" 2> "$TEMP_FILE"
        
        local choice
        choice=$(cat "$TEMP_FILE")
        case $choice in
            1) show_directory_commands ;;
            2) show_file_commands ;;
            3) show_shell_commands ;;
            4) show_system_info_commands ;;
            0|*) break ;;
        esac
    done
}

# Directory navigation commands
show_directory_commands() {
    dialog --title "Directory Navigation" --colors \
           --msgbox "\Z1Directory Navigation Commands:\Z0\n\n"\
"\Z1pwd\Z0             Print current working directory\n\n"\
"\Z1ls\Z0              List files and directories\n"\
"  • ls -l: detailed format (permissions, size, date)\n"\
"  • ls -a: include hidden files\n"\
"  • ls -lh: human-readable sizes\n\n"\
"\Z1cd\Z0              Change directory\n"\
"  • cd ~ : home directory\n"\
"  • cd - : previous directory\n"\
"  • cd ../dir : parent then 'dir'\n\n"\
"Press OK to return" 16 60
}

# File operations commands
show_file_commands() {
    dialog --title "File Operations" --colors \
           --msgbox "\Z1File Operations:\Z0\n\n"\
"\Z1cp\Z0              Copy files or directories\n"\
"  • cp file /dest/\n"\
"  • cp -r folder/ /dest/\n\n"\
"\Z1mv\Z0              Move or rename files\n"\
"  • mv src dst\n\n"\
"\Z1rm\Z0              Remove files or directories\n"\
"  • rm file\n"\
"  • rm -r dir/\n"\
"  • rm -rf dir/ (caution!)\n\n"\
"\Z1cat\Z0             Display file contents\n\n"\
"\Z1chmod\Z0           Change file permissions\n"\
"  • chmod +x file (make executable)\n"\
"  • chmod -x file (remove execute)\n"\
"  • chmod 755 file (rwxr-xr-x)\n"\
"  • chmod 644 file (rw-r--r--)\n"\
"  • chmod +r file (add read)\n"\
"  • chmod +w file (add write)\n\n"\
"Press OK to return" 20 65
}

# Shell utilities commands
show_shell_commands() {
    dialog --title "Shell Utilities" --colors \
           --msgbox "\Z1Shell Utilities:\Z0\n\n"\
"\Z1echo\Z0            Print text or variables\n"\
"  • echo \"Hello\"\n"\
"  • echo \$PATH\n\n"\
"\Z1man\Z0             Show manual page (q to quit)\n\n"\
"\Z1history\Z0         Command history\n"\
"  • history\n"\
"  • !n: repeat entry n\n\n"\
"\Z1PATH Listing\Z0    Show each PATH entry on new line\n"\
"  • echo \$PATH | tr ':' '\\n'\n\n"\
"Press OK to return" 16 60
}

# System information commands
show_system_info_commands() {
    dialog --title "System Information" --colors \
           --msgbox "\Z1System Information:\Z0\n\n"\
"\Z1uname -m\Z0        Show machine architecture\n"\
"  • Displays processor type (x86_64, arm64)\n"\
"  • Useful for system compatibility\n\n"\
"\Z1lsblk\Z0           List block devices\n"\
"  • Shows disks, partitions, mount points\n"\
"  • Use lsblk -f for filesystem info\n\n"\
"\Z1lsb_release -a\Z0  Show distribution info\n"\
"  • Displays Linux distribution details\n"\
"  • Shows version, codename, description\n\n"\
"\Z1tput cols && tput lines\Z0  Show terminal dimensions\n"\
"  • Displays terminal width (columns) and height (lines)\n"\
"  • Useful for troubleshooting display issues\n"\
"  • Minimum recommended: 80×24\n\n"\
"Press OK to return" 18 60
}

# Function to display GPU commands sub-menu
show_gpu_commands() {
    while true; do
        dialog --title "GPU Monitor Commands" \
               --menu "Select a subcategory:" 15 50 5 \
               1 "NVIDIA GPU Commands" \
               2 "AMD GPU Commands" \
               3 "General GPU Tips" \
               0 "Back to Main Menu" 2> "$TEMP_FILE"
        
        local choice
        choice=$(cat "$TEMP_FILE")
        case $choice in
            1) show_nvidia_commands ;;
            2) show_amd_commands ;;
            3) show_gpu_tips ;;
            0|*) break ;;
        esac
    done
}

# NVIDIA GPU commands
show_nvidia_commands() {
    dialog --title "NVIDIA GPU Commands" --colors \
           --msgbox "\Z1NVIDIA GPU Commands:\Z0\n\n"\
"\Z1watch -n0.1 nvidia-smi\Z0\n"\
"  • Real-time GPU monitoring (0.1s refresh)\n"\
"  • Shows utilization, memory, temperature\n"\
"  • Tip: Open in separate terminal\n\n"\
"\Z1nvidia-smi -q\Z0\n"\
"  • Detailed GPU information\n"\
"  • GPU model, driver version, memory\n"\
"  • Temperature, power, processes\n\n"\
"\Z1nvidia-smi -l 1\Z0\n"\
"  • Updates every 1 second\n"\
"  • Less resource intensive than watch\n"\
"  • Good for long-term monitoring\n\n"\
"\Z1nvidia-smi --query-gpu=timestamp,name,utilization.gpu,memory.used --format=csv\Z0\n"\
"  • Custom formatted output\n"\
"  • CSV format for logging\n\n"\
"Press OK to return" 18 75
}

# AMD GPU commands
show_amd_commands() {
    dialog --title "AMD GPU Commands" --colors \
           --msgbox "\Z1AMD GPU Commands:\Z0\n\n"\
"\Z1watch -n0.1 rocm-smi\Z0\n"\
"  • Real-time AMD GPU monitoring\n"\
"  • Shows utilization, memory, temperature\n"\
"  • Tip: Open in separate terminal\n\n"\
"\Z1rocm-smi --showuse\Z0\n"\
"  • Shows GPU utilization percentage\n"\
"  • Memory usage and temperature\n\n"\
"\Z1rocm-smi --showmeminfo\Z0\n"\
"  • Detailed memory information\n"\
"  • Total, used, free memory\n"\
"  • Memory usage per process\n\n"\
"\Z1rocm-smi --showtemp\Z0\n"\
"  • Shows GPU temperature for all GPUs\n\n"\
"\Z1rocm-smi --showpower\Z0\n"\
"  • Shows power consumption\n"\
"  • Current draw, power limit\n\n"\
"Press OK to return" 18 65
}

# GPU monitoring tips
show_gpu_tips() {
    dialog --title "GPU Monitoring Tips" --colors \
           --msgbox "\Z1GPU Monitoring Tips:\Z0\n\n"\
"General Tips:\n"\
"• Use 'q' to exit watch commands\n"\
"• Monitor in separate terminal or tmux session\n"\
"• For logging: redirect output to file\n"\
"• Use --format=csv for machine-readable output\n\n"\
"Examples:\n"\
"• \Z1nvidia-smi -l 1 > gpu_log.txt\Z0\n"\
"• \Z1watch -n1 nvidia-smi\Z0\n"\
"• \Z1rocm-smi --showuse >> amd_gpu.log\Z0\n\n"\
"Performance:\n"\
"• Use longer intervals for continuous monitoring\n"\
"• CSV format is better for data processing\n"\
"• Consider using tmux for persistent sessions\n\n"\
"Press OK to return" 18 60
}

# Function to display package management commands sub-menu
show_package_commands() {
    while true; do
        dialog --title "Package Management Commands" \
               --menu "Select a subcategory:" 15 50 7 \
               1 "System Update" \
               2 "Package Installation" \
               3 "Package Removal" \
               4 "Package Information" \
               5 "Package Maintenance" \
               6 "Package Dependencies" \
               0 "Back to Main Menu" 2> "$TEMP_FILE"
        
        local choice
        choice=$(cat "$TEMP_FILE")
        case $choice in
            1) show_system_update ;;
            2) show_package_install ;;
            3) show_package_removal ;;
            4) show_package_info ;;
            5) show_package_maintenance ;;
            6) show_package_deps ;;
            0|*) break ;;
        esac
    done
}

# System update commands
show_system_update() {
    dialog --title "System Update" --colors \
           --msgbox "\Z1System Update:\Z0\n\n"\
"\Z1sudo apt update\Z0\n"\
"  • Update package lists\n"\
"  • Always run before upgrading\n"\
"  • Downloads latest package information\n\n"\
"\Z1sudo apt upgrade\Z0\n"\
"  • Upgrade all packages\n"\
"  • Keeps existing configurations\n"\
"  • Safe upgrade method\n\n"\
"\Z1sudo apt full-upgrade\Z0\n"\
"  • Full system upgrade\n"\
"  • May remove packages if needed\n"\
"  • More comprehensive than upgrade\n\n"\
"Best Practice:\n"\
"• Always run 'apt update' first\n"\
"• Use 'upgrade' for regular updates\n"\
"• Use 'full-upgrade' for major updates\n\n"\
"Press OK to return" 18 65
}

# Package installation commands
show_package_install() {
    dialog --title "Package Installation" --colors \
           --msgbox "\Z1Package Installation:\Z0\n\n"\
"\Z1sudo apt install package_name\Z0\n"\
"  • Install a single package\n"\
"  • Example: sudo apt install vim\n\n"\
"\Z1sudo apt install package1 package2\Z0\n"\
"  • Install multiple packages\n"\
"  • Example: sudo apt install vim git curl\n\n"\
"\Z1sudo apt install -y package_name\Z0\n"\
"  • Install without confirmation prompt\n"\
"  • Useful for automation scripts\n\n"\
"\Z1sudo apt reinstall package_name\Z0\n"\
"  • Reinstall an existing package\n"\
"  • Useful for fixing corrupted packages\n\n"\
"Tips:\n"\
"• Use tab completion for package names\n"\
"• Check 'apt show' before installing\n\n"\
"Press OK to return" 18 65
}

# Package removal commands
show_package_removal() {
    dialog --title "Package Removal" --colors \
           --msgbox "\Z1Package Removal:\Z0\n\n"\
"\Z1sudo apt remove package_name\Z0\n"\
"  • Remove package but keep configs\n"\
"  • Example: sudo apt remove vim\n"\
"  • Configuration files remain\n\n"\
"\Z1sudo apt purge package_name\Z0\n"\
"  • Remove package and configs\n"\
"  • Complete removal\n"\
"  • Example: sudo apt purge vim\n\n"\
"\Z1sudo apt autoremove\Z0\n"\
"  • Remove unused packages\n"\
"  • Cleans up dependencies\n"\
"  • Frees up disk space\n\n"\
"\Z1sudo apt autoremove --purge\Z0\n"\
"  • Remove unused packages and configs\n"\
"  • Most thorough cleanup\n\n"\
"Press OK to return" 18 60
}

# Package information commands
show_package_info() {
    dialog --title "Package Information" --colors \
           --msgbox "\Z1Package Information:\Z0\n\n"\
"\Z1apt search keyword\Z0\n"\
"  • Search for packages\n"\
"  • Example: apt search python\n"\
"  • Shows package names and descriptions\n\n"\
"\Z1apt show package_name\Z0\n"\
"  • Show detailed package information\n"\
"  • Version, dependencies, description, size\n"\
"  • Example: apt show vim\n\n"\
"\Z1apt list --installed\Z0\n"\
"  • List all installed packages\n"\
"  • Shows version information\n\n"\
"\Z1apt list --upgradable\Z0\n"\
"  • List packages with available updates\n"\
"  • Useful before upgrading\n\n"\
"Press OK to return" 18 65
}

# Package maintenance commands
show_package_maintenance() {
    dialog --title "Package Maintenance" --colors \
           --msgbox "\Z1Package Maintenance:\Z0\n\n"\
"\Z1sudo apt-mark hold package_name\Z0\n"\
"  • Prevent package from being upgraded\n"\
"  • Example: sudo apt-mark hold kernel\n\n"\
"\Z1sudo apt-mark unhold package_name\Z0\n"\
"  • Allow package to be upgraded again\n"\
"  • Example: sudo apt-mark unhold kernel\n\n"\
"\Z1sudo dpkg --get-selections | grep hold\Z0\n"\
"  • List all held packages\n"\
"  • Shows package status\n\n"\
"\Z1sudo apt clean\Z0\n"\
"  • Remove downloaded .deb files\n"\
"  • Frees up disk space in /var/cache/apt\n\n"\
"\Z1sudo apt autoclean\Z0\n"\
"  • Remove old .deb files\n"\
"  • Keeps recent versions\n\n"\
"Press OK to return" 18 65
}

# Package dependencies commands
show_package_deps() {
    dialog --title "Package Dependencies" --colors \
           --msgbox "\Z1Package Dependencies:\Z0\n\n"\
"\Z1apt-cache depends package_name\Z0\n"\
"  • Show package dependencies\n"\
"  • Example: apt-cache depends python3\n"\
"  • Lists what the package needs\n\n"\
"\Z1apt-cache rdepends package_name\Z0\n"\
"  • Show reverse dependencies\n"\
"  • Shows what depends on the package\n"\
"  • Useful before removing packages\n\n"\
"\Z1cat /var/log/apt/history.log\Z0\n"\
"  • View package installation history\n"\
"  • Shows installations, removals, upgrades\n"\
"  • Useful for troubleshooting\n\n"\
"Tips:\n"\
"• Check dependencies before removing\n"\
"• Use reverse dependencies to avoid conflicts\n\n"\
"Press OK to return" 18 65
}

# Function to display system monitoring commands sub-menu
show_monitor_commands() {
    while true; do
        dialog --title "System Monitoring Commands" \
               --menu "Select a subcategory:" 15 50 7 \
               1 "System Overview" \
               2 "Process Monitoring" \
               3 "Resource Monitoring" \
               4 "Hardware Monitoring" \
               5 "Network Monitoring" \
               6 "Performance Stats" \
               0 "Back to Main Menu" 2> "$TEMP_FILE"
        
        local choice
        choice=$(cat "$TEMP_FILE")
        case $choice in
            1) show_system_overview ;;
            2) show_process_monitoring ;;
            3) show_resource_monitoring ;;
            4) show_hardware_monitoring ;;
            5) show_network_monitoring ;;
            6) show_performance_stats ;;
            0|*) break ;;
        esac
    done
}

# System overview commands
show_system_overview() {
    dialog --title "System Overview" --colors \
           --msgbox "\Z1System Overview:\Z0\n\n"\
"\Z1landscape-sysinfo\Z0\n"\
"  • Comprehensive system information\n"\
"  • System load, memory, disk usage\n"\
"  • Network info, process count\n"\
"  • Ubuntu-specific tool\n\n"\
"\Z1watch -n0.1 landscape-sysinfo\Z0\n"\
"  • Real-time system overview\n"\
"  • Updates every 0.1 seconds\n"\
"  • Good for real-time monitoring\n"\
"  • Tip: Open in separate terminal\n\n"\
"\Z1neofetch\Z0\n"\
"  • System information with ASCII art\n"\
"  • Shows OS, kernel, hardware info\n"\
"  • Great for system identification\n\n"\
"Press OK to return" 18 60
}

# Process monitoring commands
show_process_monitoring() {
    dialog --title "Process Monitoring" --colors \
           --msgbox "\Z1Process Monitoring:\Z0\n\n"\
"\Z1htop\Z0\n"\
"  • Interactive process viewer\n"\
"  • Tree view, CPU/Memory usage\n"\
"  • F1-F10: Menu options\n"\
"  • F3: Search, F4: Filter, F9: Kill\n"\
"  • q: Quit\n\n"\
"\Z1btop\Z0\n"\
"  • Modern system monitor\n"\
"  • Beautiful CPU/Memory graphs\n"\
"  • Network traffic, process list\n"\
"  • 1-5: Switch views, h: Help\n\n"\
"\Z1top\Z0\n"\
"  • Classic process monitor\n"\
"  • Built-in to most systems\n"\
"  • q: Quit, k: Kill process\n\n"\
"Press OK to return" 18 60
}

# Resource monitoring commands
show_resource_monitoring() {
    dialog --title "Resource Monitoring" --colors \
           --msgbox "\Z1Resource Monitoring:\Z0\n\n"\
"\Z1glances\Z0\n"\
"  • Advanced system monitor\n"\
"  • CPU/Memory/Disk/Network usage\n"\
"  • Temperature, battery status\n"\
"  • Web interface: http://localhost:61208\n"\
"  • Options: -t (refresh), -w (web server)\n\n"\
"\Z1free -h\Z0\n"\
"  • Memory usage in human-readable format\n"\
"  • Shows total, used, free, available\n\n"\
"\Z1df -h\Z0\n"\
"  • Disk space usage\n"\
"  • Shows filesystem, size, used, available\n\n"\
"Press OK to return" 18 65
}

# Hardware monitoring commands
show_hardware_monitoring() {
    dialog --title "Hardware Monitoring" --colors \
           --msgbox "\Z1Hardware Monitoring:\Z0\n\n"\
"\Z1sensors\Z0\n"\
"  • Display sensor information\n"\
"  • CPU temperature, fan speeds\n"\
"  • Voltage readings, power usage\n"\
"  • Requires lm-sensors package\n\n"\
"\Z1sensors-detect\Z0\n"\
"  • Detect and configure sensors\n"\
"  • Run as root\n"\
"  • Follows interactive prompts\n"\
"  • Updates /etc/sensors3.conf\n\n"\
"\Z1lscpu\Z0\n"\
"  • Display CPU information\n"\
"  • Architecture, cores, cache\n\n"\
"\Z1lshw\Z0\n"\
"  • List hardware information\n"\
"  • Detailed hardware inventory\n\n"\
"Press OK to return" 18 60
}

# Network monitoring commands
show_network_monitoring() {
    dialog --title "Network Monitoring" --colors \
           --msgbox "\Z1Network Monitoring:\Z0\n\n"\
"\Z1iftop\Z0\n"\
"  • Network bandwidth monitor\n"\
"  • Shows bandwidth usage per connection\n"\
"  • Host connections, port usage\n"\
"  • h: Help, q: Quit, s/d: Sort by source/dest\n\n"\
"\Z1nethogs\Z0\n"\
"  • Network traffic by process\n"\
"  • Shows which process uses bandwidth\n"\
"  • Process name, bandwidth usage\n"\
"  • Connection details\n\n"\
"\Z1ss -tuln\Z0\n"\
"  • Show network connections\n"\
"  • TCP/UDP listening ports\n"\
"  • Modern replacement for netstat\n\n"\
"Press OK to return" 18 60
}

# Performance statistics commands
show_performance_stats() {
    dialog --title "Performance Statistics" --colors \
           --msgbox "\Z1Performance Statistics:\Z0\n\n"\
"\Z1vmstat 1\Z0\n"\
"  • Virtual memory statistics\n"\
"  • Updates every second\n"\
"  • CPU usage, memory stats, I/O\n"\
"  • System events and context switches\n\n"\
"\Z1iostat 1\Z0\n"\
"  • I/O statistics\n"\
"  • Updates every second\n"\
"  • CPU usage, disk I/O rates\n"\
"  • Transfer rates per device\n\n"\
"\Z1sar -u 1\Z0\n"\
"  • System activity reporter\n"\
"  • CPU utilization every second\n"\
"  • Part of sysstat package\n\n"\
"Tips:\n"\
"• Use 'watch' for periodic updates\n"\
"• Redirect to files for logging\n\n"\
"Press OK to return" 18 65
}

# Function to display network commands
show_network_commands() {
    dialog --title "Network Commands" \
           --colors \
           --msgbox "IP Link:
\Z1sudo ip link set dev 'net_device_name' 'up_or_down'\Z0
- Set network device up or down

Netplan:
\Z1sudo netplan apply\Z0
- Apply network configuration

Network Manager:
\Z1nmcli\Z0
- Network Manager command line tool

Device Info:
\Z1nmcli device show\Z0
- Show network device information

Connection Info:
\Z1nmcli connection show\Z0
- Show network connection information" 15 60
}

# Function to display git commands sub-menu
show_git_commands() {
    while true; do
        dialog --title "Git Commands" \
               --menu "Select a subcategory:" 15 50 7 \
               1 "Configuration" \
               2 "Repository Setup" \
               3 "Basic Operations" \
               4 "Branch Management" \
               5 "Remote Operations" \
               6 "History & Inspection" \
               0 "Back to Main Menu" 2> "$TEMP_FILE"
        
        local choice
        choice=$(cat "$TEMP_FILE")
        case $choice in
            1) show_git_config ;;
            2) show_git_setup ;;
            3) show_git_basic ;;
            4) show_git_branches ;;
            5) show_git_remote ;;
            6) show_git_history ;;
            0|*) break ;;
        esac
    done
}

# Git configuration commands
show_git_config() {
    dialog --title "Git - Configuration" --colors \
           --msgbox "\Z1Git Configuration:\Z0\n\n"\
"\Z1git config --global user.name 'Name'\Z0\n"\
"  • Set your Git username globally\n"\
"  • Required for all commits\n\n"\
"\Z1git config --global user.email 'email'\Z0\n"\
"  • Set your Git email globally\n"\
"  • Required for all commits\n\n"\
"\Z1git config --global core.editor 'vim'\Z0\n"\
"  • Set default text editor\n"\
"  • Options: vim, nano, code\n\n"\
"\Z1git config --global init.defaultBranch main\Z0\n"\
"  • Set default branch name\n"\
"  • Modern default is 'main'\n\n"\
"\Z1git config --list\Z0\n"\
"  • List all Git configurations\n\n"\
"Press OK to return" 18 65
}

# Git repository setup commands
show_git_setup() {
    dialog --title "Git - Repository Setup" --colors \
           --msgbox "\Z1Repository Setup:\Z0\n\n"\
"\Z1git init\Z0\n"\
"  • Initialize a new Git repository\n"\
"  • Creates .git directory\n"\
"  • First step for any new project\n\n"\
"\Z1git clone 'git_url'\Z0\n"\
"  • Clone repository from remote\n"\
"  • Downloads complete history\n\n"\
"\Z1git clone 'url' 'folder'\Z0\n"\
"  • Clone to specific folder\n"\
"  • Creates directory if needed\n\n"\
"Examples:\n"\
"• git clone https://github.com/user/repo.git\n"\
"• git clone https://github.com/user/repo.git myproject\n\n"\
"Press OK to return" 18 65
}

# Git basic operations commands
show_git_basic() {
    dialog --title "Git - Basic Operations" --colors \
           --msgbox "\Z1Basic Operations:\Z0\n\n"\
"\Z1git status\Z0\n"\
"  • Show repository status\n"\
"  • Modified files, staged changes\n\n"\
"\Z1git add 'file'\Z0\n"\
"  • Add file to staging area\n\n"\
"\Z1git add .\Z0\n"\
"  • Add all files to staging\n\n"\
"\Z1git commit -m 'message'\Z0\n"\
"  • Commit staged changes\n"\
"  • Message should be descriptive\n\n"\
"\Z1git commit --amend\Z0\n"\
"  • Modify the last commit\n"\
"  • Only use before pushing\n\n"\
"Press OK to return" 18 60
}

# Git branch management commands
show_git_branches() {
    dialog --title "Git - Branch Management" --colors \
           --msgbox "\Z1Branch Management:\Z0\n\n"\
"\Z1git branch\Z0\n"\
"  • List all local branches\n"\
"  • Current branch marked with *\n\n"\
"\Z1git branch -a\Z0\n"\
"  • List all branches (local and remote)\n\n"\
"\Z1git branch 'name'\Z0\n"\
"  • Create a new branch\n\n"\
"\Z1git checkout 'branch'\Z0\n"\
"  • Switch to existing branch\n\n"\
"\Z1git checkout -b 'name'\Z0\n"\
"  • Create and switch to new branch\n\n"\
"\Z1git merge 'branch'\Z0\n"\
"  • Merge branch into current branch\n\n"\
"Press OK to return" 18 60
}

# Git remote operations commands
show_git_remote() {
    dialog --title "Git - Remote Operations" --colors \
           --msgbox "\Z1Remote Operations:\Z0\n\n"\
"\Z1git remote -v\Z0\n"\
"  • List remote repositories\n"\
"  • Shows fetch and push URLs\n\n"\
"\Z1git fetch\Z0\n"\
"  • Download objects from remote\n"\
"  • Doesn't merge changes\n\n"\
"\Z1git pull\Z0\n"\
"  • Fetch and merge from remote\n"\
"  • Updates current branch\n\n"\
"\Z1git push\Z0\n"\
"  • Push changes to remote\n\n"\
"\Z1git push -u origin 'branch'\Z0\n"\
"  • Push and set upstream branch\n"\
"  • Enables future push without args\n\n"\
"Press OK to return" 18 60
}

# Git history and inspection commands
show_git_history() {
    dialog --title "Git - History & Inspection" --colors \
           --msgbox "\Z1History & Inspection:\Z0\n\n"\
"\Z1git log\Z0\n"\
"  • Show commit history\n"\
"  • Hash, author, date, message\n\n"\
"\Z1git log --oneline\Z0\n"\
"  • Compact commit history\n"\
"  • One line per commit\n\n"\
"\Z1git log --graph --oneline --all\Z0\n"\
"  • Graphical commit history\n"\
"  • Visualizes branch structure\n\n"\
"\Z1git diff\Z0\n"\
"  • Show changes between commits\n\n"\
"\Z1git show 'commit_hash'\Z0\n"\
"  • Show specific commit details\n\n"\
"\Z1git stash / git stash pop\Z0\n"\
"  • Temporarily save/restore changes\n\n"\
"Press OK to return" 18 60
}

# Function to display docker commands sub-menu
show_docker_commands() {
    while true; do
        dialog --title "Docker Commands" \
               --menu "Select a subcategory:" 15 50 6 \
               1 "Container Management" \
               2 "Image Management" \
               3 "Container Interaction" \
               4 "System Management" \
               0 "Back to Main Menu" 2> "$TEMP_FILE"
        
        local choice
        choice=$(cat "$TEMP_FILE")
        case $choice in
            1) show_docker_containers ;;
            2) show_docker_images ;;
            3) show_docker_interaction ;;
            4) show_docker_system ;;
            0|*) break ;;
        esac
    done
}

# Docker container management
show_docker_containers() {
    dialog --title "Docker - Container Management" --colors \
           --msgbox "\Z1Container Management:\Z0\n\n"\
"\Z1docker ps\Z0              List running containers\n"\
"\Z1docker ps -a\Z0           List all containers\n"\
"\Z1docker run image\Z0       Create and start container\n"\
"\Z1docker run -it image\Z0   Interactive container\n"\
"\Z1docker run -d image\Z0    Detached mode\n"\
"\Z1docker run -p 8080:80\Z0  Port mapping\n\n"\
"\Z1docker start container\Z0 Start stopped container\n"\
"\Z1docker stop container\Z0  Stop running container\n"\
"\Z1docker restart container\Z0 Restart container\n"\
"\Z1docker rm container\Z0    Remove container\n"\
"\Z1docker rm -f container\Z0 Force remove\n\n"\
"Press OK to return" 18 65
}

# Docker image management
show_docker_images() {
    dialog --title "Docker - Image Management" --colors \
           --msgbox "\Z1Image Management:\Z0\n\n"\
"\Z1docker images\Z0          List local images\n"\
"\Z1docker pull image\Z0      Download image\n"\
"\Z1docker build -t name .\Z0 Build from Dockerfile\n"\
"\Z1docker rmi image\Z0       Remove image\n"\
"\Z1docker rmi -f image\Z0    Force remove image\n"\
"\Z1docker tag src target\Z0  Tag image\n\n"\
"Examples:\n"\
"• docker pull ubuntu:latest\n"\
"• docker build -t myapp .\n"\
"• docker tag myapp:latest myapp:v1.0\n\n"\
"Press OK to return" 16 60
}

# Docker container interaction
show_docker_interaction() {
    dialog --title "Docker - Container Interaction" --colors \
           --msgbox "\Z1Container Interaction:\Z0\n\n"\
"\Z1docker exec -it container bash\Z0 Execute bash\n"\
"\Z1docker exec container command\Z0   Run command\n"\
"\Z1docker logs container\Z0           View logs\n"\
"\Z1docker logs -f container\Z0        Follow logs\n"\
"\Z1docker inspect container\Z0        Detailed info\n"\
"\Z1docker cp file container:/path\Z0  Copy to container\n"\
"\Z1docker cp container:/path file\Z0  Copy from container\n\n"\
"Examples:\n"\
"• docker exec -it abc123 bash\n"\
"• docker logs -f myapp\n"\
"• docker cp file.txt abc123:/tmp/\n\n"\
"Press OK to return" 16 65
}

# Docker system management
show_docker_system() {
    dialog --title "Docker - System Management" --colors \
           --msgbox "\Z1System Management:\Z0\n\n"\
"\Z1docker system df\Z0       Show disk usage\n"\
"\Z1docker system prune\Z0    Remove unused objects\n"\
"\Z1docker system prune -a\Z0 Remove all unused\n"\
"\Z1docker volume ls\Z0       List volumes\n"\
"\Z1docker network ls\Z0      List networks\n"\
"\Z1docker info\Z0            System information\n"\
"\Z1docker version\Z0         Version information\n\n"\
"Tips:\n"\
"• Regular cleanup with 'docker system prune'\n"\
"• Use 'docker run --rm' for temporary containers\n"\
"• Always specify tags to avoid 'latest' confusion\n\n"\
"Press OK to return" 18 60
}

# Function to display user & group management commands sub-menu
show_user_group_commands() {
    while true; do
        dialog --title "User & Group Management" \
               --menu "Select a subcategory:" 15 50 7 \
               1 "User Creation & Management" \
               2 "Group Creation & Management" \
               3 "User Information & Listing" \
               4 "Password & Security" \
               5 "User Permissions & Sudo" \
               6 "Advanced User Management" \
               0 "Back to Main Menu" 2> "$TEMP_FILE"
        
        local choice
        choice=$(cat "$TEMP_FILE")
        case $choice in
            1) show_user_creation ;;
            2) show_group_management ;;
            3) show_user_info ;;
            4) show_password_security ;;
            5) show_user_permissions ;;
            6) show_advanced_user_mgmt ;;
            0|*) break ;;
        esac
    done
}

# User creation and management
show_user_creation() {
    dialog --title "User Creation & Management" --colors \
           --msgbox "\Z1User Creation & Management:\Z0\n\n"\
"\Z1sudo adduser username\Z0\n"\
"  • Interactive user creation (recommended)\n"\
"  • Creates home directory automatically\n"\
"  • Sets up shell and initial files\n"\
"  • Prompts for password and user info\n\n"\
"\Z1sudo useradd username\Z0\n"\
"  • Basic user creation (manual setup required)\n"\
"  • No home directory by default\n"\
"  • Use with -m flag to create home\n\n"\
"\Z1sudo useradd -m -s /bin/bash username\Z0\n"\
"  • Create user with home directory and bash shell\n"\
"  • -m: create home directory\n"\
"  • -s: specify shell\n\n"\
"\Z1sudo deluser username\Z0\n"\
"  • Remove user (keeps home directory)\n\n"\
"\Z1sudo deluser --remove-home username\Z0\n"\
"  • Remove user and home directory\n\n"\
"Press OK to return" 20 65
}

# Group creation and management
show_group_management() {
    dialog --title "Group Creation & Management" --colors \
           --msgbox "\Z1Group Creation & Management:\Z0\n\n"\
"\Z1sudo addgroup groupname\Z0\n"\
"  • Create a new group\n"\
"  • Example: sudo addgroup developers\n\n"\
"\Z1sudo groupadd groupname\Z0\n"\
"  • Alternative group creation command\n"\
"  • More basic than addgroup\n\n"\
"\Z1sudo adduser username groupname\Z0\n"\
"  • Add existing user to group\n"\
"  • Example: sudo adduser john developers\n\n"\
"\Z1sudo gpasswd -a username groupname\Z0\n"\
"  • Alternative way to add user to group\n\n"\
"\Z1sudo gpasswd -d username groupname\Z0\n"\
"  • Remove user from group\n\n"\
"\Z1sudo delgroup groupname\Z0\n"\
"  • Delete a group\n"\
"  • Group must be empty first\n\n"\
"Press OK to return" 18 65
}

# User information and listing
show_user_info() {
    dialog --title "User Information & Listing" --colors \
           --msgbox "\Z1User Information & Listing:\Z0\n\n"\
"\Z1whoami\Z0                 Current username\n\n"\
"\Z1id\Z0                     Current user ID and groups\n\n"\
"\Z1id username\Z0            Specific user ID and groups\n\n"\
"\Z1who\Z0                    Currently logged in users\n\n"\
"\Z1w\Z0                      Detailed logged in users info\n\n"\
"\Z1getent passwd\Z0          List all users\n\n"\
"\Z1getent passwd username\Z0 Specific user information\n\n"\
"\Z1getent group\Z0           List all groups\n\n"\
"\Z1groups username\Z0        Show user's groups\n\n"\
"\Z1finger username\Z0        Detailed user information\n"\
"  • Requires finger package\n\n"\
"Press OK to return" 18 60
}

# Password and security management
show_password_security() {
    dialog --title "Password & Security" --colors \
           --msgbox "\Z1Password & Security:\Z0\n\n"\
"\Z1sudo passwd username\Z0\n"\
"  • Change user password (as admin)\n"\
"  • Prompts for new password\n\n"\
"\Z1passwd\Z0\n"\
"  • Change your own password\n"\
"  • Prompts for current and new password\n\n"\
"\Z1sudo passwd -l username\Z0\n"\
"  • Lock user account\n"\
"  • Prevents login with password\n\n"\
"\Z1sudo passwd -u username\Z0\n"\
"  • Unlock user account\n"\
"  • Re-enables password login\n\n"\
"\Z1sudo chage -l username\Z0\n"\
"  • Show password aging information\n"\
"  • Expiration dates and policies\n\n"\
"\Z1sudo chage username\Z0\n"\
"  • Interactive password aging setup\n\n"\
"Press OK to return" 18 60
}

# User permissions and sudo access
show_user_permissions() {
    dialog --title "User Permissions & Sudo" --colors \
           --msgbox "\Z1User Permissions & Sudo:\Z0\n\n"\
"\Z1sudo adduser username sudo\Z0\n"\
"  • Add user to sudo group\n"\
"  • Grants administrative privileges\n"\
"  • User can use sudo command\n\n"\
"\Z1sudo gpasswd -d username sudo\Z0\n"\
"  • Remove user from sudo group\n"\
"  • Removes administrative privileges\n\n"\
"\Z1sudo visudo\Z0\n"\
"  • Edit sudoers file safely\n"\
"  • Configure detailed sudo permissions\n"\
"  • Syntax checking included\n\n"\
"\Z1sudo -l\Z0\n"\
"  • List current user's sudo privileges\n\n"\
"\Z1sudo -l -U username\Z0\n"\
"  • List specific user's sudo privileges\n\n"\
"Common Groups:\n"\
"• sudo: Administrative access\n"\
"• docker: Docker daemon access\n"\
"• www-data: Web server files\n\n"\
"Press OK to return" 20 60
}

# Advanced user management
show_advanced_user_mgmt() {
    dialog --title "Advanced User Management" --colors \
           --msgbox "\Z1Advanced User Management:\Z0\n\n"\
"\Z1sudo usermod -l newname oldname\Z0\n"\
"  • Rename user account\n"\
"  • Changes username only\n\n"\
"\Z1sudo usermod -d /new/home -m username\Z0\n"\
"  • Change and move home directory\n"\
"  • -m moves contents to new location\n\n"\
"\Z1sudo usermod -s /bin/zsh username\Z0\n"\
"  • Change user's default shell\n"\
"  • Common shells: /bin/bash, /bin/zsh, /bin/fish\n\n"\
"\Z1sudo usermod -e YYYY-MM-DD username\Z0\n"\
"  • Set account expiration date\n"\
"  • Format: 2024-12-31\n\n"\
"\Z1sudo usermod -G group1,group2 username\Z0\n"\
"  • Set user's groups (replaces current)\n"\
"  • Use -a -G to append groups\n\n"\
"\Z1last username\Z0\n"\
"  • Show user login history\n\n"\
"Press OK to return" 20 65
}


# Main menu function
show_main_menu() {
    while true; do
        # Display the main menu using dialog utility
        # Optimized dimensions for better performance
        dialog --title "Help Command Center v$VERSION" \
               --menu "Select a category:" 17 50 9 \
               1 "Basic Commands" \
               2 "GPU Monitor" \
               3 "Package Management" \
               4 "System Monitoring" \
               5 "Network Commands" \
               6 "Git Commands" \
               7 "Docker Commands" \
               8 "User & Group Management" \
               0 "Exit" 2> "$TEMP_FILE"

        # Read the user's menu selection from the temporary file
        local choice
        choice=$(cat "$TEMP_FILE")
        
        # Process the user's choice using case statement
        case $choice in
            1) show_basic_commands ;;        # Call function to display basic commands sub-menu
            2) show_gpu_commands ;;          # Call function to display GPU monitoring commands
            3) show_package_commands ;;      # Call function to display package management commands
            4) show_monitor_commands ;;      # Call function to display system monitoring commands
            5) show_network_commands ;;      # Call function to display network commands
            6) show_git_commands ;;          # Call function to display git commands
            7) show_docker_commands ;;       # Call function to display docker commands sub-menu
            8) show_user_group_commands ;;   # Call function to display user & group management commands
            0|*) break ;;                    # Exit on "Exit" or any other input (ESC key, invalid choice)
        esac
    done
}

# Main execution
main() {
    init_script
    show_main_menu
}

# Run the script
main "$@" 