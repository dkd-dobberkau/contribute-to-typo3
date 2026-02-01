# Install TYPO3

**Goal:** Set up the TYPO3 database and backend access.

## Step 1: Run TYPO3 Setup

Initialize the database and create an admin user:

```bash
ddev exec touch FIRST_INSTALL && \
ddev typo3 setup \
  --driver=mysqli \
  --host=db \
  --port=3306 \
  --dbname=db \
  --username=db \
  --password=db \
  --admin-username=admin \
  --admin-user-password='Admin123!' \
  --admin-email='your.email@example.com' \
  --project-name='TYPO3 Contribution' \
  --no-interaction \
  --server-type=apache \
  --force
```

!!! success "Expected Output"
    ```
    Congratulations - TYPO3 Setup is done.
    ```

## Step 2: Activate Extensions

Set up core extensions and the styleguide:

```bash
ddev typo3 extension:setup
ddev typo3 extension:activate indexed_search
ddev typo3 extension:activate styleguide
```

## Step 3: Generate Test Data (Optional)

The styleguide extension can create test pages demonstrating all TCA types:

```bash
ddev typo3 styleguide:generate -c
```

## Step 4: Launch TYPO3

Open the backend in your browser:

```bash
ddev launch typo3
```

Or navigate directly to: **https://t3c-main.ddev.site/typo3/**

Log in with:

- **Username:** `admin`
- **Password:** `Admin123!`

## Verify Installation

In the TYPO3 backend:

1. Check **Admin Tools → Environment → System Information**
2. Verify PHP version (8.2) and database (MariaDB)
3. Browse **Page → Styleguide** if you generated test data

## Next Step

[Contribution Workflow](contribution-workflow.md) - Learn how to create and submit patches.
