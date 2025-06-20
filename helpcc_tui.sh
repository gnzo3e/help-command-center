#!/bin/bash
#
# Help Command Center (HCC)
# A terminal-based interactive command reference tool
#
# Author: Sugair AlSugair
# License: MIT
# Version: 1.0.0
#
# Description:
# This script provides an interactive TUI (Text User Interface) for accessing
# commonly used Linux commands and their explanations. It uses the 'dialog'
# utility to create a user-friendly interface with categorized command references.
#
# Dependencies:
# - dialog: For creating the TUI
# - bash: Shell interpreter
#
# Usage:
# ./helpcc_tui.sh
#
# Categories:
# 1. GPU Monitor - NVIDIA and AMD GPU monitoring commands
# 2. Package Management - System package management commands
# 3. System Monitoring - System and process monitoring tools
# 4. Network Commands - Network interface and configuration commands
# 5. Git Commands - Git version control system commands

# Check if dialog is installed
if ! command -v dialog &> /dev/null; then
    echo "Error: dialog is not installed. Please install it using:"
    echo "sudo apt-get install dialog"
    exit 1
fi

# Temporary file for command output
TEMP_FILE=$(mktemp)

# Function to display GPU commands
show_gpu_commands() {
    dialog --title "GPU Monitor Commands" \
           --colors \
           --msgbox "NVIDIA GPU Commands:
\Z1watch -n0.1 nvidia-smi\Z0
- Opens NVIDIA's usage prompt with 0.1s refresh rate
- Shows GPU utilization, memory, temperature
- Tip: Open in a separate terminal

\Z1nvidia-smi -q\Z0
- Detailed GPU information
- Shows:
  * GPU model
  * Driver version
  * Memory usage
  * Temperature
  * Power usage
  * Processes using GPU

\Z1nvidia-smi -l 1\Z0
- Updates every 1 second
- Less resource intensive than watch
- Good for long-term monitoring

\Z1nvidia-smi --query-gpu=timestamp,name,utilization.gpu,memory.used,memory.total,temperature.gpu --format=csv\Z0
- Custom formatted output
- CSV format for logging
- Shows specific metrics

AMD GPU Commands:
\Z1watch -n0.1 rocm-smi\Z0
- Opens AMD's usage prompt with 0.1s refresh rate
- Shows GPU utilization, memory, temperature
- Tip: Open in a separate terminal

\Z1rocm-smi --showuse\Z0
- Shows GPU utilization
- Displays:
  * GPU usage percentage
  * Memory usage
  * Temperature

\Z1rocm-smi --showmeminfo\Z0
- Detailed memory information
- Shows:
  * Total memory
  * Used memory
  * Free memory
  * Memory usage per process

\Z1rocm-smi --showtemp\Z0
- Shows GPU temperature
- Displays temperature for all GPUs

\Z1rocm-smi --showpower\Z0
- Shows power consumption
- Displays:
  * Current power draw
  * Power limit
  * Power usage per GPU

Common Tips:
- Use 'q' to exit watch commands
- Monitor in separate terminal or tmux session
- For logging: redirect output to file
- Example: \Z1nvidia-smi -l 1 > gpu_log.txt\Z0
- Use --format=csv for machine-readable output" 25 80
}

# Function to display package management commands
show_package_commands() {
    dialog --title "Package Management Commands" \
           --colors \
           --msgbox "System Update:
\Z1sudo apt update\Z0
- Update package lists
- Run before upgrading

\Z1sudo apt upgrade\Z0
- Upgrade all packages
- Keeps existing configurations

\Z1sudo apt full-upgrade\Z0
- Full system upgrade
- May remove packages if needed

Package Installation:
\Z1sudo apt install package_name\Z0
- Install a package
- Example: \Z1sudo apt install vim\Z0

\Z1sudo apt install package1 package2\Z0
- Install multiple packages
- Example: \Z1sudo apt install vim git\Z0

Package Removal:
\Z1sudo apt remove package_name\Z0
- Remove package but keep configs
- Example: \Z1sudo apt remove vim\Z0

\Z1sudo apt purge package_name\Z0
- Remove package and configs
- Example: \Z1sudo apt purge vim\Z0

\Z1sudo apt autoremove\Z0
- Remove unused packages
- Cleans up dependencies

Package Information:
\Z1apt search keyword\Z0
- Search for packages
- Example: \Z1apt search python\Z0

\Z1apt show package_name\Z0
- Show package details
- Shows:
  * Version
  * Dependencies
  * Description
  * Size

Package Hold/Unhold:
\Z1sudo apt-mark hold package_name\Z0
- Stop package from being upgraded
- Example: \Z1sudo apt-mark hold kernel\Z0

\Z1sudo apt-mark unhold package_name\Z0
- Allow package to be upgraded
- Example: \Z1sudo apt-mark unhold kernel\Z0

\Z1sudo dpkg --get-selections | grep 'hold'\Z0
- List all held packages
- Shows package status

Package Cleanup:
\Z1sudo apt clean\Z0
- Remove downloaded .deb files
- Frees up disk space

\Z1sudo apt autoclean\Z0
- Remove old .deb files
- Keeps recent versions

Package Dependencies:
\Z1apt-cache depends package_name\Z0
- Show package dependencies
- Example: \Z1apt-cache depends python3\Z0

\Z1apt-cache rdepends package_name\Z0
- Show reverse dependencies
- Shows what depends on package

Package History:
\Z1cat /var/log/apt/history.log\Z0
- View package history
- Shows:
  * Installations
  * Removals
  * Upgrades

Common Tips:
- Always run 'apt update' before upgrades
- Use 'apt search' to find packages
- Check 'apt show' before installing
- Use 'apt autoremove' regularly
- Keep track of held packages" 25 80
}

# Function to display system monitoring commands
show_monitor_commands() {
    dialog --title "System Monitoring Commands" \
           --colors \
           --msgbox "System Overview:
\Z1landscape-sysinfo\Z0
- Shows comprehensive system information
- Displays:
  * System load
  * Memory usage
  * Disk usage
  * Network info
  * Process count

\Z1watch -n0.1 landscape-sysinfo\Z0
- Updates every 0.1 seconds
- Good for real-time monitoring
- Tip: Open in separate terminal

Process Monitoring:
\Z1htop\Z0
- Interactive process viewer
- Features:
  * Tree view of processes
  * CPU/Memory usage
  * System load
  * Temperature
  * Customizable display
- Navigation:
  * F1-F10: Menu options
  * Arrow keys: Navigate
  * Space: Select process
  * F3: Search
  * F4: Filter
  * F5: Tree view
  * F6: Sort by
  * F9: Kill process
  * q: Quit

\Z1btop\Z0
- Modern system monitor
- Features:
  * CPU usage graphs
  * Memory usage
  * Network traffic
  * Process list
  * Temperature
- Navigation:
  * 1-5: Switch views
  * h: Help
  * q: Quit
- Tip: Run in tmux session

System Resources:
\Z1glances\Z0
- Advanced system monitor
- Features:
  * CPU/Memory/Disk usage
  * Network monitoring
  * Process list
  * Temperature
  * Battery status
- Web interface: http://localhost:61208
- Options:
  * -t: Set refresh time
  * -w: Start web server
  * -b: Show network bytes
  * -f: Show filesystem

\Z1vmstat 1\Z0
- Virtual memory statistics
- Updates every second
- Shows:
  * CPU usage
  * Memory stats
  * I/O stats
  * System events

\Z1iostat 1\Z0
- I/O statistics
- Updates every second
- Shows:
  * CPU usage
  * Disk I/O
  * Transfer rates

Hardware Monitoring:
\Z1sensors\Z0
- Display sensor information
- Shows:
  * CPU temperature
  * Fan speeds
  * Voltage readings
  * Power usage

\Z1sensors-detect\Z0
- Detect and configure sensors
- Run as root
- Follows interactive prompts
- Updates /etc/sensors3.conf

Network Monitoring:
\Z1iftop\Z0
- Network bandwidth monitor
- Shows:
  * Bandwidth usage
  * Host connections
  * Port usage
- Navigation:
  * h: Help
  * q: Quit
  * s: Source host
  * d: Destination host

\Z1nethogs\Z0
- Network traffic by process
- Shows:
  * Process name
  * Bandwidth usage
  * Connection details

Common Tips:
- Use 'q' to exit most monitors
- Monitor in separate terminal or tmux
- For logging: redirect output to file
- Example: \Z1vmstat 1 > system_log.txt\Z0
- Use 'watch' for periodic updates
- Combine tools for comprehensive monitoring" 30 80
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

# Function to display git commands
show_git_commands() {
    dialog --title "Git Commands" \
           --colors \
           --msgbox "Configuration:
\Z1git config --global user.name 'Your Name'\Z0
- Set your Git username globally
- Required for all commits
- Example: \Z1git config --global user.name 'John Doe'\Z0

\Z1git config --global user.email 'your.email@example.com'\Z0
- Set your Git email globally
- Required for all commits
- Example: \Z1git config --global user.email 'john.doe@example.com'\Z0

\Z1git config --global core.editor 'vim'\Z0
- Set default text editor for commit messages
- Options: vim, nano, code (VS Code), etc.
- Example: \Z1git config --global core.editor 'nano'\Z0

\Z1git config --global init.defaultBranch main\Z0
- Set default branch name for new repositories
- Modern default is 'main' instead of 'master'
- Example: \Z1git config --global init.defaultBranch main\Z0

\Z1git config --list\Z0
- List all Git configurations
- Shows both global and local settings
- Use --show-origin to see where each setting is defined

Repository Setup:
\Z1git init\Z0
- Initialize a new Git repository
- Creates .git directory with repository data
- First step for any new project

\Z1git clone 'git_url'\Z0
- Clone a repository from remote source
- Downloads complete repository history
- Example: \Z1git clone https://github.com/user/repo.git\Z0

\Z1git clone 'git_url' 'folder_name'\Z0
- Clone repository to specific folder
- Creates directory if it doesn't exist
- Example: \Z1git clone https://github.com/user/repo.git my-project\Z0

Basic Operations:
\Z1git status\Z0
- Show repository status
- Displays:
  * Modified files
  * Staged changes
  * Untracked files
  * Current branch

\Z1git add 'file_name'\Z0
- Add specific file to staging area
- Prepares file for commit
- Example: \Z1git add README.md\Z0

\Z1git add 'folder_name'\Z0
- Add entire folder to staging
- Includes all files in folder
- Example: \Z1git add src/\Z0

\Z1git add .\Z0
- Add all files to staging
- Includes new and modified files
- Excludes files in .gitignore

\Z1git commit -m 'message'\Z0
- Commit staged changes with message
- Message should be clear and descriptive
- Example: \Z1git commit -m 'Add user authentication'\Z0

\Z1git commit --amend\Z0
- Modify the last commit
- Can change message or add forgotten files
- Only use before pushing to remote

Branch Management:
\Z1git branch\Z0
- List all local branches
- Current branch marked with *
- Shows basic commit info

\Z1git branch -a\Z0
- List all branches (local and remote)
- Remote branches prefixed with 'remotes/'
- Shows tracking relationships

\Z1git branch 'branch_name'\Z0
- Create a new branch
- Doesn't switch to new branch
- Example: \Z1git branch feature-login\Z0

\Z1git checkout 'branch_name'\Z0
- Switch to existing branch
- Updates working directory
- Example: \Z1git checkout main\Z0

\Z1git checkout -b 'branch_name'\Z0
- Create and switch to new branch
- Combines branch and checkout
- Example: \Z1git checkout -b bug-fix\Z0

\Z1git merge 'branch_name'\Z0
- Merge branch into current branch
- Creates merge commit
- Example: \Z1git merge feature-login\Z0

Remote Operations:
\Z1git remote -v\Z0
- List remote repositories
- Shows fetch and push URLs
- Example output:
  origin  https://github.com/user/repo.git (fetch)
  origin  https://github.com/user/repo.git (push)

\Z1git fetch\Z0
- Download objects and refs from remote
- Doesn't merge changes
- Updates remote tracking branches

\Z1git pull\Z0
- Fetch and merge from remote
- Updates current branch
- Example: \Z1git pull origin main\Z0

\Z1git push\Z0
- Push changes to remote
- Updates remote repository
- Example: \Z1git push origin main\Z0

\Z1git push -u origin 'branch_name'\Z0
- Push and set upstream branch
- Enables future push without arguments
- Example: \Z1git push -u origin feature-login\Z0

History & Inspection:
\Z1git log\Z0
- Show commit history
- Displays:
  * Commit hash
  * Author
  * Date
  * Commit message

\Z1git log --oneline\Z0
- Show compact commit history
- One line per commit
- Shows hash and message

\Z1git log --graph --oneline --all\Z0
- Show graphical commit history
- Visualizes branch structure
- Shows all branches

\Z1git diff\Z0
- Show changes between commits
- Displays:
  * Added lines (+)
  * Removed lines (-)
  * Context

\Z1git diff 'file_name'\Z0
- Show changes in specific file
- Compares working directory with staging
- Example: \Z1git diff README.md\Z0

\Z1git show 'commit_hash'\Z0
- Show specific commit details
- Displays:
  * Commit info
  * Changes made
  * Example: \Z1git show a1b2c3d\Z0

Stashing:
\Z1git stash\Z0
- Stash changes temporarily
- Saves uncommitted changes
- Cleans working directory

\Z1git stash list\Z0
- List all stashes
- Shows stash index and description
- Example: stash@{0}: WIP on main

\Z1git stash pop\Z0
- Apply and remove latest stash
- Restores stashed changes
- May cause conflicts

\Z1git stash apply\Z0
- Apply latest stash without removing
- Keeps stash in list
- Safer than pop" 30 80
}

# Function to display basic commands
show_basic_commands() {
    dialog --title "Basic Commands" \
           --colors \
           --msgbox "\Z1\pwd\Z0
Print the current working directory
  Example: \Z\1pwd\Z0

\Z1\ls\Z0
List files and directories
  \Z1\ls -l\Z0: Long format (permissions, size, date)
  \Z1\ls -la\Z0: Include hidden files (those starting with .)
  Tip: Use \Z1\ls -lh\Z0 for human-readable sizes

\Z1\cd\Z0
Change directory
  \Z1\cd ~\Z0: Go to home directory
  \Z1\cd -\Z0: Go to previous directory
  \Z1cd ../dirname\Z0: Go up one directory and into 'dirname'
  Example: \Z1cd /tmp\Z0

\Z1\cp\Z0
Copy files or directories
  \Z1\cp file.txt /tmp/\Z0: Copy file to /tmp
  \Z1\cp -r folder/ /tmp/\Z0: Copy folder recursively

\Z1\mv\Z0
Move or rename files/directories
  \Z1\mv old.txt new.txt\Z0: Rename file
  \Z1\mv file.txt /tmp/\Z0: Move file to /tmp

\Z1\rm\Z0
Remove files or directories
  \Z1\rm file.txt\Z0: Remove file
  \Z1\rm -r folder/\Z0: Remove folder recursively
  \Z1\rm -rf folder/\Z0: Force remove folder and contents
  Tip: Be careful with -rf!

\Z1\cat\Z0
Show contents of a file
  Example: \Z1\cat file.txt\Z0

\Z1\echo\Z0
Print text or variables
  \Z1\echo "Hello"\Z0: Print text
  \Z1\echo \$PATH\Z0: Print variable value

\Z1\man\Z0
Show manual page for a command
  Example: \Z1\man ls\Z0
  Tip: Press q to quit the manual

\Z1\history\Z0
Show command history
  Example: \Z1\history\Z0
  Tip: Use \Z1!n\Z0 to repeat command number n

\Z1Show \PATH Directories\Z0
Prints each directory in your PATH on a new line
  \Z1echo \$PATH | tr ":" "\\n"\Z0
  Tip: Pipe to grep to search for a directory:
    \Z1echo \$PATH | tr ":" "\\n" | grep local\Z0

Tip: Press OK to return to the main menu.
" 40 90
}

# Main menu
while true; do
    dialog --title "Helpful Command Center" \
           --menu "Select a category:" 17 60 7 \
           1 "Basic" \
           2 "GPU Monitor" \
           3 "Package Management" \
           4 "System Monitoring" \
           5 "Network Commands" \
           6 "Git Commands" \
           0 "Exit" 2> $TEMP_FILE

    choice=$(cat $TEMP_FILE)
    case $choice in
        1) show_basic_commands ;;
        2) show_gpu_commands ;;
        3) show_package_commands ;;
        4) show_monitor_commands ;;
        5) show_network_commands ;;
        6) show_git_commands ;;
        0) break ;;
        *) break ;;
    esac
done

# Cleanup
rm -f $TEMP_FILE
clear 