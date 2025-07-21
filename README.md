# Help Command Center (HCC)

A sophisticated terminal-based interactive command reference tool designed for Linux system administrators, developers, and power users who need quick access to command documentation and examples.

## Description

Help Command Center is a modular, high-performance TUI (Text User Interface) utility that provides instant access to categorized Linux command references. Built with bash and the dialog utility, it features an optimized sub-menu architecture that loads quickly and provides comprehensive command coverage with practical examples.

## Features

- **🚀 High Performance**: Modular sub-menu architecture with lazy loading for instant navigation
- **🎯 Comprehensive Coverage**: 8 main categories with 31+ specialized sub-menus
- **💡 Practical Examples**: Real-world command usage with detailed explanations
- **🛡️ Robust Design**: Error handling, dependency checking, and automatic cleanup
- **🎨 User-Friendly**: Color-coded output and intuitive navigation
- **⚡ Optimized**: Fast loading with efficient dialog box sizing
- **🔧 Modular**: Easy to extend and maintain

## System Requirements

- **Operating System**: Linux (Ubuntu 24.04.2 LTS or compatible)
- **Shell**: bash (version 4.0 or higher recommended)
- **Terminal**: Any terminal with ANSI color support
- **Dependencies**: `dialog` utility (automatically checked at startup)

## Installation & Setup

### Quick Installation

1. **Clone the repository**:
```bash
git clone https://github.com/gnzo3e/help-command-center.git
cd help-command-center
```

2. **Install dependencies** (if not already installed):
```bash
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install dialog
```

3. **Make executable**:
```bash
chmod +x helpcc_tui.sh
```

4. **Test the installation**:
```bash
./helpcc_tui.sh
```

### Recommended Setup: Global Alias

For maximum convenience, set up a global alias to run HCC from anywhere:

1. **Edit your bash aliases**:
```bash
nano ~/.bash_aliases
```

2. **Add the alias** (replace with your actual path):
```bash
alias helpcc="/full/path/to/help-command-center/helpcc_tui.sh"
```

3. **Reload your shell configuration**:
```bash
source ~/.bashrc
# or source ~/.bash_aliases
```

4. **Now run from anywhere**:
```bash
helpcc
```

### Alternative Installation Methods

**Direct download and install**:
```bash
# Download to /usr/local/bin for system-wide access
sudo wget https://raw.githubusercontent.com/gnzo3e/help-command-center/main/helpcc_tui.sh -O /usr/local/bin/helpcc
sudo chmod +x /usr/local/bin/helpcc
```

**Symlink installation**:
```bash
# Create a symlink in your PATH
ln -s /full/path/to/helpcc_tui.sh ~/.local/bin/helpcc
```

## Usage Guide

### Basic Usage

**Start the application**:
```bash
./helpcc_tui.sh
# or if you set up the alias:
helpcc
```

### Navigation Instructions

- **🔄 Navigate**: Use arrow keys (↑↓) to move through menu options
- **✅ Select**: Press `Enter` to select a menu item or view command help
- **🔙 Go Back**: Press `Escape` or select "Back" to return to previous menu
- **❌ Exit**: Select "Exit" from main menu or press `Ctrl+C` to quit
- **📋 Scroll**: In help dialogs, use `Page Up`/`Page Down` for long content

### Menu Structure Navigation

1. **Main Menu** → Choose a category (Basic Commands, Git, Docker, etc.)
2. **Category Menu** → Choose a sub-category (e.g., File Operations, Branch Management)
3. **Command Help** → View detailed command explanations and examples
4. **Return Path** → Back to sub-category → Back to main menu

### Tips for Effective Usage

- **Start with Basic Commands** if you're new to Linux
- **Use Git Commands** for version control workflows
- **Check System Monitoring** for performance troubleshooting
- **Browse Package Management** for software installation help
- **Explore Docker Commands** for containerization tasks
- **Access User & Group Management** for system administration

## Example Session

```
$ helpcc

┌─────────────────────────────────────────┐
│           Help Command Center           │
│                                         │
│  1. Basic Commands                      │
│  2. GPU Monitor                         │
│  3. Package Management                  │
│  4. System Monitoring                   │
│  5. Network Commands                    │
│  6. Git Commands                        │
│  7. Docker Commands                     │
│  8. User & Group Management             │
│  0. Exit                                │
└─────────────────────────────────────────┘

→ Select "User & Group Management"
→ Select "User Creation & Management"
→ View "adduser vs useradd - User creation methods"
→ Get detailed explanation and best practices
```

## Command Categories & Structure

### 1. 📁 Basic Commands (4 Sub-menus)
Essential Linux commands organized by function:
- **Directory Navigation**: `pwd`, `ls`, `cd` variations and examples
- **File Operations**: `cp`, `mv`, `rm`, `cat`, `chmod` with practical usage
- **Shell Utilities**: `echo`, `man`, `history`, PATH management
- **System Information**: `uname`, `lsblk`, `lsb_release`, `tput` for system details

### 2. 🎮 GPU Monitor (3 Sub-menus)
Graphics card monitoring and diagnostics:
- **NVIDIA GPU Commands**: `nvidia-smi` variants and monitoring tools
- **AMD GPU Commands**: `rocm-smi` and ROCm ecosystem tools
- **General GPU Tips**: Best practices and troubleshooting guides

### 3. 📦 Package Management (6 Sub-menus)
Comprehensive APT package system management:
- **System Update**: `apt update`, `upgrade`, `full-upgrade` workflows
- **Package Installation**: Install, reinstall, and installation options
- **Package Removal**: Remove, purge, autoremove with safety tips
- **Package Information**: Search, show, list commands for package discovery
- **Package Maintenance**: Hold, clean, autoclean for system maintenance
- **Package Dependencies**: Dependency analysis and package history

### 4. 📊 System Monitoring (6 Sub-menus)
Advanced system performance and resource monitoring:
- **System Overview**: `landscape-sysinfo`, `neofetch` for system summaries
- **Process Monitoring**: `htop`, `btop`, `top` for process management
- **Resource Monitoring**: `glances`, `free`, `df` for resource tracking
- **Hardware Monitoring**: `sensors`, `lscpu`, `lshw` for hardware info
- **Network Monitoring**: `iftop`, `nethogs`, `ss` for network analysis
- **Performance Stats**: `vmstat`, `iostat`, `sar` for performance metrics

### 5. 🌐 Network Commands
Network configuration and interface management:
- IP link management, netplan configuration, NetworkManager tools

### 6. 🔀 Git Commands (6 Sub-menus)
Complete Git version control workflow:
- **Configuration**: User setup, editor configuration, default settings
- **Repository Setup**: Initialize, clone, and repository creation
- **Basic Operations**: Status, add, commit, amend workflows
- **Branch Management**: Branch operations, checkout, merge strategies
- **Remote Operations**: Remote management, fetch, pull, push operations
- **History & Inspection**: Log analysis, diff, show, stash management

### 7. 🐳 Docker Commands (4 Sub-menus)
Comprehensive Docker container and image management:
- **Container Management**: Run, start, stop, remove container operations
- **Image Management**: Image operations, pull, build, tag, remove
- **Container Interaction**: Exec, logs, inspect, copy operations
- **System Management**: System cleanup, volume, and network management

### 8. 🔐 User & Group Management (6 Sub-menus)
Complete user and group administration for system management:
- **User Creation & Management**: `adduser`, `useradd`, `deluser` with home directory options
- **Group Creation & Management**: `addgroup`, user-to-group assignment, group deletion
- **User Information & Listing**: `whoami`, `id`, `who`, `getent` for user discovery
- **Password & Security**: Password management, account locking, aging policies
- **User Permissions & Sudo**: Sudo access, privilege management, `visudo` configuration
- **Advanced User Management**: Username changes, shell modification, account expiration

## Performance Optimizations

- **Lazy Loading**: Sub-menus load only when accessed
- **Optimized Dialogs**: Efficient box sizing for faster rendering
- **Memory Management**: Proper resource cleanup and minimal memory footprint
- **Signal Handling**: Graceful exits and automatic cleanup
- **Error Recovery**: Robust error handling with informative messages

## Advanced Features

### Dependency Management
- Automatic `dialog` dependency checking on startup
- Clear error messages with installation instructions
- Graceful fallback for missing dependencies

### Error Handling & Recovery
- Robust error handling with `set -euo pipefail`
- Automatic cleanup of temporary files
- Signal trapping for clean exits (SIGINT, SIGTERM)
- Informative error messages with troubleshooting hints

### Performance Features
- Modular loading: Sub-menus load only when accessed
- Optimized dialog dimensions for various terminal sizes
- Efficient memory usage with proper resource cleanup
- Fast navigation with minimal system calls

## Configuration & Customization

### Current Configuration
The script uses sensible defaults optimized for most use cases:
- Dialog box sizes: 15-18 height × 50-75 width
- Color scheme: System default with ANSI color support
- Navigation: Standard dialog key bindings

### Future Configuration (config.yaml)
A sample `config.yaml` is included for future extensibility:
```yaml
# Future configuration options
display:
  theme: "default"
  colors: true
  
search:
  fuzzy_matching: false
  
logging:
  enabled: false
  
cache:
  enabled: false
  
aliases:
  custom_commands: {}
```

*Note: The current version does not use config.yaml, but it's provided for future enhancements.*

## Testing & Quality Assurance

### Automated Testing
Run the included test suite:
```bash
cd tests
./test_helpcc.sh
```

The test script validates:
- ✅ Script syntax and structure
- ✅ Dependency availability
- ✅ Function definitions
- ✅ Menu structure integrity
- ✅ Error handling capabilities

### Manual Testing Checklist
- [ ] All main menu options accessible
- [ ] All sub-menus load correctly
- [ ] Command examples display properly
- [ ] Navigation works as expected
- [ ] Exit/back buttons function correctly
- [ ] Error conditions handled gracefully

## Troubleshooting

### Common Issues & Solutions

**Issue**: `dialog: command not found`
```bash
# Solution: Install dialog
sudo apt-get update
sudo apt-get install dialog
```

**Issue**: Colors not displaying correctly
```bash
# Solution: Check terminal color support
echo $TERM
# Ensure your terminal supports ANSI colors
```

**Issue**: Slow performance or display issues
```bash
# Solution: Check terminal size
tput cols && tput lines
# Resize terminal if too small (minimum 80×24 recommended)
```

**Issue**: Navigation not working
```bash
# Solution: Use keyboard instead of mouse
# Arrow keys for navigation, Enter to select, Escape to go back
```

**Issue**: Script won't start
```bash
# Solution: Check permissions and dependencies
chmod +x helpcc_tui.sh
command -v dialog || sudo apt-get install dialog
```

### Debug Mode
For troubleshooting script issues:
```bash
# Run with debug output
bash -x ./helpcc_tui.sh

# Or check for syntax errors
bash -n ./helpcc_tui.sh
```

## Contributing

We welcome contributions! Help Command Center is designed to be easily extensible and maintainable.

### How to Contribute

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/new-commands`
3. **Make your changes**: Follow the existing code structure
4. **Test thoroughly**: Ensure all menu paths work correctly
5. **Update documentation**: Modify README.md and script comments
6. **Submit a pull request**: Describe your changes clearly

### Contribution Guidelines

#### Adding New Commands
- Follow the existing sub-menu structure
- Include practical examples and clear explanations
- Test commands on the target system (Ubuntu 24.04.2 LTS)
- Maintain consistent dialog box sizing (15-18 height, 50-75 width)

#### Code Style
- Use `snake_case` for function names
- Follow existing indentation (4 spaces)
- Include descriptive comments for complex logic
- Use meaningful variable names
- Follow bash best practices (`set -euo pipefail`)

#### Adding New Categories
```bash
# Example function structure for new categories
show_new_category() {
    while true; do
        dialog --clear --title "New Category" \
               --menu "Choose a sub-category:" 15 60 8 \
               1 "Sub-category 1" \
               2 "Sub-category 2" \
               3 "Back to Main Menu" \
               2>"$TEMP_FILE"
        
        choice=$(<"$TEMP_FILE")
        case $choice in
            1) show_subcategory_1 ;;
            2) show_subcategory_2 ;;
            3) break ;;
            *) break ;;
        esac
    done
}
```

#### Testing Your Changes
- Test all navigation paths
- Verify dialog boxes display correctly
- Check error handling scenarios
- Run the test suite: `./tests/test_helpcc.sh`
- Test on different terminal sizes

### Areas for Contribution

- **New Command Categories**: Security tools, development tools, multimedia, file system management
- **Enhanced Formatting**: Better color schemes, improved layouts
- **Configuration System**: Implement config.yaml functionality
- **Search Functionality**: Add command search capabilities across all categories
- **Documentation**: Improve help text, add more examples, expand user management scenarios
- **Testing**: Expand test coverage, add integration tests for user management functions
- **Performance**: Further optimize loading times for larger category sets
- **Accessibility**: Improve navigation for different accessibility needs
- **Integration**: Add support for external command databases or plugins

## Project Roadmap

### Version 1.2.0 (Planned)
- [ ] Search functionality across all commands
- [ ] Configuration file support (config.yaml)
- [ ] Custom command additions
- [ ] Export command references to text files
- [ ] Bookmark frequently used commands

### Version 1.3.0 (Future)
- [ ] Plugin system for external command libraries
- [ ] Integration with man pages
- [ ] Command history and usage tracking
- [ ] Customizable themes and layouts
- [ ] Multi-language support

## License

This project is licensed under a **Custom Non-Commercial License** - see the [LICENSE](LICENSE) file for complete details.

### License Summary
- ❌ **Commercial use** - Commercial use is prohibited
- ✅ **Modification** - Modify and create derivative works for non-commercial use
- ✅ **Distribution** - Distribute original or modified versions for non-commercial use
- ✅ **Private use** - Use for personal/private projects
- ✅ **Educational use** - Use for educational and learning purposes
- ⚠️ **Liability** - No warranty or liability from authors
- ⚠️ **Attribution** - Must include original copyright notice

## Author & Acknowledgments

**Author**: gnzo3e  
**Version**: 1.1.0  
**Created**: 2024  
**Last Updated**: June 2025

### Special Thanks
- **Contributors**: All community members who have helped improve this project
- **Inspiration**: Born from the daily need for quick command reference in terminal environments
- **Community**: Linux system administrators and developers who provided feedback and suggestions
- **Tools**: Built with appreciation for the `dialog` utility and bash scripting capabilities

### Design Philosophy
> *"The commands and categories included in this tool are the ones I use most frequently in my daily workflow. This makes the Help Command Center especially practical and tailored for real-world usage."*

The Help Command Center is designed by practitioners, for practitioners - focusing on the commands that matter most in day-to-day Linux system administration and development work.

---

## Quick Reference Card

| Feature | Command | Description |
|---------|---------|-------------|
| **Start HCC** | `./helpcc_tui.sh` or `helpcc` | Launch the Help Command Center |
| **Navigate** | `↑↓ Arrow Keys` | Move through menu options |
| **Select** | `Enter` | Choose menu item or view help |
| **Go Back** | `Escape` or "Back" | Return to previous menu |
| **Exit** | `Ctrl+C` or "Exit" | Quit the application |
| **Scroll Help** | `Page Up/Down` | Navigate long help text |

### Quick Access by Category
- **Beginners**: Start with "Basic Commands" → "Directory Navigation"
- **Git Users**: "Git Commands" → "Basic Operations" or "Branch Management"
- **System Admins**: "System Monitoring" → "Process Monitoring" or "User & Group Management"
- **Docker Users**: "Docker Commands" → "Container Management"
- **Package Management**: "Package Management" → "System Update" or "Package Installation"
- **User Administration**: "User & Group Management" → "User Creation & Management" or "User Permissions & Sudo"

**Happy command-line navigation! 🚀**
