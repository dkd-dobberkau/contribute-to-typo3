# DDEV Environment

**Goal:** Set up DDEV to provide PHP, MariaDB, and Apache for TYPO3 development.

## Step 1: Configure DDEV

Run this from your TYPO3 directory:

```bash
ddev config \
  --project-name='t3c-main' \
  --project-type='typo3' \
  --docroot='.' \
  --database='mariadb:10.11' \
  --php-version='8.2' \
  --composer-version='stable' \
  --nodejs-version='22' \
  --webserver-type='apache-fpm' \
  --timezone='Europe/Berlin' \
  --web-environment='TYPO3_CONTEXT=Development'
```

This creates `.ddev/config.yaml` with the proper settings.

## Step 2: Start DDEV

```bash
ddev start
```

First run downloads container images (may take a few minutes).

!!! success "Expected Output"
    ```
    Starting t3c-main...
    Successfully started t3c-main
    Project can be reached at https://t3c-main.ddev.site
    ```

## Step 3: Install Dependencies

Use the TYPO3 test runner script:

```bash
./Build/Scripts/runTests.sh -s composerInstall
```

Or with DDEV Composer:

```bash
ddev composer install
```

!!! info "Legacy Mode"
    The resulting installation runs in Legacy mode (not Composer mode), which matches how core tests run.

## Verify Setup

Check DDEV status:

```bash
ddev status
```

Expected output shows running containers for web and database.

## Useful DDEV Commands

| Command | Description |
|---------|-------------|
| `ddev start` | Start the environment |
| `ddev stop` | Stop the environment |
| `ddev restart` | Restart containers |
| `ddev ssh` | SSH into the web container |
| `ddev logs` | View container logs |
| `ddev describe` | Show project details and URLs |

## Next Step

[Install TYPO3](typo3-install.md) - Set up the database and TYPO3 backend.
