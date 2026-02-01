# Prerequisites

**Goal:** Ensure you have all required tools installed before starting.

## Required Tools

### Operating System

- macOS
- Linux
- Windows with WSL2

### Docker

A container runtime is required for DDEV:

=== "Docker Desktop"

    Download from [docker.com](https://www.docker.com/products/docker-desktop/)

=== "OrbStack (macOS)"

    ```bash
    brew install orbstack
    ```

=== "Colima (macOS/Linux)"

    ```bash
    brew install colima
    colima start
    ```

### DDEV

DDEV provides the PHP/database environment:

=== "macOS (Homebrew)"

    ```bash
    brew install ddev/ddev/ddev
    ```

=== "Linux"

    ```bash
    curl -fsSL https://ddev.com/install.sh | bash
    ```

=== "Windows (WSL2)"

    ```bash
    curl -fsSL https://ddev.com/install.sh | bash
    ```

### Git

Git must be installed with SSH support:

=== "macOS"

    ```bash
    # Usually pre-installed, or:
    brew install git
    ```

=== "Linux (Debian/Ubuntu)"

    ```bash
    sudo apt install git
    ```

### Code Editor

Any editor works. Recommended:

- **PhpStorm** with TYPO3 plugin
- **VS Code** with PHP extensions

## Verify Installation

Run these commands to verify your setup:

```bash
docker --version    # Docker version 24.x or higher
ddev --version      # DDEV version 1.23.x or higher
git --version       # git version 2.x or higher
ssh -V              # OpenSSH_x.x
```

## Next Step

[Create Accounts](accounts.md) - Set up your TYPO3.org account for Gerrit and Forge access.
