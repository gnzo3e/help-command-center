# Help Command Center

A command-line interface tool for managing and accessing help documentation and commands.

## Description

Help Command Center is a terminal-based utility that provides quick access to help documentation, command references, and system information. It offers an interactive interface for navigating through various help topics and commands.

## Features

- Interactive terminal user interface
- Quick access to help documentation
- Command reference lookup
- System information display
- Easy navigation through help topics
- Organized help categories: Basic Commands, GPU Monitor, Package Management, System Monitoring, Network Commands, Git Commands

## Dependencies

- bash (shell interpreter)
- dialog (for the TUI interface)

Install dialog if needed:
```bash
sudo apt-get install dialog
```

## Installation

1. Clone the repository:
```bash
git clone https://github.com/gnzo3e/help-command-center.git
cd help-command-center
```

2. Make the script executable:
```bash
chmod +x helpcc_tui.sh
```

## Usage

Run the script:
```bash
./helpcc_tui.sh
```

### Categories Available
- **Basic Commands:** Common navigation, file, and shell utilities, organized and easy to read.
- **GPU Monitor:** NVIDIA/AMD GPU monitoring commands.
- **Package Management:** apt/dpkg package management.
- **System Monitoring:** System, process, and hardware monitoring.
- **Network Commands:** Network interface and configuration.
- **Git Commands:** Git configuration, workflow, and inspection.

## Configuration

A sample `config.yaml` is included for future configuration options (display, search, logging, cache, aliases). The current script does not use this file, but it is provided for future extensibility.

## Testing

A test script is provided in the `tests/` directory:

```bash
cd tests
./test_helpcc.sh
```

This script runs basic checks on the help command center script.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

gnzo3e

## Acknowledgments

- Thanks to all contributors who have helped shape this project
- Inspired by the need for quick access to help documentation in terminal environments 
