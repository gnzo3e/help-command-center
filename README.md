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

> **Note:** The commands and categories included in this tool are the ones I use most frequently in my daily workflow. This makes the Help Command Center especially practical and tailored for real-world usage.
>
> **Tip:** My preferred way to run this tool is by creating an alias named `helpcc` in my `.bash_aliases` file. This allows you to launch the Help Command Center from anywhere in your terminal with a simple command.
>
> **To set this up:**
> 1. Open (or create) your `~/.bash_aliases` file:
>    ```bash
>    nano ~/.bash_aliases
>    ```
> 2. Add the following line (replace `/path/to/helpcc_tui.sh` with the actual path):
>    ```bash
>    alias helpcc="/path/to/helpcc_tui.sh"
>    ```
> 3. Save and close the file, then reload your aliases:
>    ```bash
>    source ~/.bash_aliases
>    ```
> 4. Now you can run the tool from anywhere by typing:
>    ```bash
>    helpcc
>    ```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

gnzo3e

## Acknowledgments

- Thanks to all contributors who have helped shape this project
- Inspired by the need for quick access to help documentation in terminal environments 
