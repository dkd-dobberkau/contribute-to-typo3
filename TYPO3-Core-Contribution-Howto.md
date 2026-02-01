# How to Contribute to TYPO3 Core

A comprehensive guide to setting up your development environment and contributing code to TYPO3 CMS Core.

## Overview

Contributing to TYPO3 Core requires a specific workflow using Gerrit for code review and Forge for issue tracking. This guide walks you through the complete setup process and contribution workflow.

## Prerequisites

Before you begin, ensure you have the following installed on your system:

- A computer running Windows with WSL2, macOS, or Linux
- Docker Desktop (or alternatives like OrbStack, Podman, or Colima)
- DDEV (installed on top of Docker)
- Git with knowledge of rebasing and commit management
- A code editor or IDE (PhpStorm with TYPO3 plugin recommended, or VS Code)

## Step 1: Create Your Accounts

You need a typo3.org account to access all contribution tools. This single account provides SSO access to:

- **Forge** (forge.typo3.org): The issue tracker based on Redmine
- **Gerrit** (review.typo3.org): The code review system
- **Slack** (typo3.slack.com): Community communication (recommended)

### Register at my.typo3.org

1. Go to https://my.typo3.org and create an account
2. Use your real name and a valid email address
3. Verify your email address via the confirmation link

### Set Up Gerrit SSH Access

1. Generate an SSH key pair if you don't have one
2. Log into https://review.typo3.org with your typo3.org credentials
3. Go to Settings and add your public SSH key
4. Test your connection:

```bash
ssh -p 29418 <YOUR_TYPO3_USERNAME>@review.typo3.org
```

A successful connection shows a welcome message.

### Join Slack (Recommended)

Join the TYPO3 Slack workspace at https://typo3.slack.com. The `#typo3-cms-coredev` channel is specifically for core development discussions.

## Step 2: Clone the TYPO3 Repository

Create a working directory and clone the TYPO3 mono-repository:

```bash
mkdir ~/TYPO3-Contribution
cd ~/TYPO3-Contribution
git clone git@github.com:typo3/typo3.git .
```

### Configure Git

Set up your Git identity (use the same email as your typo3.org account):

```bash
git config user.name "Your Real Name"
git config user.email "your.email@example.com"
```

Enable automatic rebasing to avoid merge commits:

```bash
git config branch.autosetuprebase remote
```

### Set Up the Push URL for Gerrit

Configure Git to push to Gerrit instead of GitHub:

```bash
git remote set-url --push origin ssh://<YOUR_TYPO3_USERNAME>@review.typo3.org:29418/Packages/TYPO3.CMS.git
```

### Install Git Hooks

The commit-msg hook is mandatory. It generates the Change-Id required by Gerrit:

```bash
composer gerrit:setup
```

Or manually copy the hooks:

```bash
cp Build/git-hooks/commit-msg .git/hooks/
cp Build/git-hooks/pre-commit .git/hooks/
chmod +x .git/hooks/commit-msg .git/hooks/pre-commit
```

### Create a Commit Message Template (Optional but Recommended)

Create a file `~/.gitmessage.txt`:

```
[TYPE] Subject line (max 52 chars)

Description of what the change does.
Wrap lines at 72 characters.

Resolves: #ISSUE_NUMBER
Releases: main
```

Configure Git to use it:

```bash
git config commit.template ~/.gitmessage.txt
```

## Step 3: Set Up DDEV

DDEV provides the PHP, database, and web server environment.

### Initialize DDEV

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

### Start DDEV

```bash
ddev start
```

### Install Dependencies

```bash
ddev composer install
```

Or using the runTests.sh script (recommended):

```bash
./Build/Scripts/runTests.sh -s composerInstall
```

## Step 4: Set Up TYPO3

### Run the Setup

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
  --admin-user-password='YourSecurePassword123!' \
  --admin-email='your.email@example.com' \
  --project-name='TYPO3 Contribution' \
  --no-interaction \
  --server-type=apache \
  --force
```

### Activate Extensions

```bash
ddev typo3 extension:setup && \
ddev typo3 extension:activate indexed_search && \
ddev typo3 extension:activate styleguide
```

### Generate Test Data (Optional)

The styleguide extension can generate test pages:

```bash
ddev typo3 styleguide:generate -c
```

### Launch TYPO3

```bash
ddev launch
```

Access the backend at https://t3c-main.ddev.site/typo3/

## Step 5: The Contribution Workflow

### Find or Create a Forge Issue

Every patch requires a matching issue on Forge:

1. Search existing issues at https://forge.typo3.org/projects/typo3cms-core/issues or https://forger.typo3.com
2. If no issue exists, create one with a clear description
3. Note the issue number (e.g., #12345)

### Make Your Changes

1. Always work on the `main` branch
2. Do not create feature branches
3. Make your code changes
4. Follow the TYPO3 Coding Guidelines (CGL)

Fix CGL issues automatically:

```bash
./Build/Scripts/runTests.sh -s cgl
```

### Run Tests

```bash
# Unit tests
./Build/Scripts/runTests.sh -s unit

# Functional tests
./Build/Scripts/runTests.sh -s functional
```

### Commit Your Changes

Create a single commit with a properly formatted message:

```bash
git add .
git commit
```

#### Commit Message Format

```
[TYPE] Subject line in imperative mood (max 52 chars)

Extended description explaining what the change does.
Wrap at 72 characters. Focus on what changed, not what
was broken (that belongs in the Forge issue).

Resolves: #12345
Releases: main, 13.4
```

**Valid TYPE keywords:**

- `[BUGFIX]` - Fixes a bug
- `[FEATURE]` - Adds new functionality
- `[TASK]` - Maintenance, refactoring, cleanup
- `[DOCS]` - Documentation changes only
- `[CLEANUP]` - Code cleanup without functional changes
- `[SECURITY]` - Security fixes (restricted workflow)

#### Subject Line Rules

- Maximum 52 characters
- Use imperative mood ("Fix bug" not "Fixed bug")
- No period at the end
- The golden rule: "If applied, this commit will [your subject]"

### Push to Gerrit

```bash
git push origin HEAD:refs/for/main
```

For work-in-progress patches:

```bash
git push origin HEAD:refs/for/main%wip
```

Gerrit responds with a URL to your review.

### Update Your Patch

If reviewers request changes:

1. Make the required changes
2. Amend your commit (keep the Change-Id intact):

```bash
git add .
git commit --amend
```

3. Push again:

```bash
git push origin HEAD:refs/for/main
```

## Step 6: The Review Process

### Understanding Gerrit Votes

Patches require approval before merging:

- **Code-Review**: +1 (looks good) or +2 (approved, Core Team only)
- **Verified**: +1 (tested and works)
- Core CI automatically runs tests and votes

**Requirements for merge:**
- At least 2 people verified (+1 Verified each)
- At least 2 people reviewed code (one must be Core Team with +2)
- Core CI passes (+1)

### Reviewing Other Patches

Contributing reviews is valuable:

1. Find patches at https://review.typo3.org or https://forger.typo3.com
2. Cherry-pick patches to test locally:

```bash
git fetch https://review.typo3.org/Packages/TYPO3.CMS refs/changes/XX/XXXXX/Y && git cherry-pick FETCH_HEAD
```

3. Test the functionality
4. Vote and comment in Gerrit

## Keeping Your Environment Updated

Regularly sync with upstream:

```bash
Build/Scripts/runTests.sh -s clean && \
git fetch --all && \
git reset --hard origin/main && \
git pull --rebase && \
./Build/Scripts/runTests.sh -u && \
./Build/Scripts/runTests.sh -s composerInstall && \
ddev typo3 cache:flush && \
ddev typo3 cache:warmup && \
ddev typo3 extension:setup
```

## Quick Reference: Essential Commands

| Task | Command |
|------|---------|
| Start environment | `ddev start` |
| Stop environment | `ddev stop` |
| Install dependencies | `./Build/Scripts/runTests.sh -s composerInstall` |
| Fix code style | `./Build/Scripts/runTests.sh -s cgl` |
| Run unit tests | `./Build/Scripts/runTests.sh -s unit` |
| Run functional tests | `./Build/Scripts/runTests.sh -s functional` |
| Clear cache | `ddev typo3 cache:flush` |
| Push to Gerrit | `git push origin HEAD:refs/for/main` |
| Push as WIP | `git push origin HEAD:refs/for/main%wip` |

## Helpful Resources

- **Official Contribution Guide**: https://docs.typo3.org/m/typo3/guide-contributionworkflow/main/en-us/
- **Forge Issue Tracker**: https://forge.typo3.org/projects/typo3cms-core/issues
- **Gerrit Code Review**: https://review.typo3.org
- **Forger (Search Issues/Reviews)**: https://forger.typo3.com
- **Slack**: https://typo3.slack.com (`#typo3-cms-coredev`)
- **TYPO3 Coding Guidelines**: https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/CodingGuidelines/

## Common Pitfalls

**"Permission denied (publickey)" when pushing:**
Check your SSH key setup in Gerrit settings and verify your push URL.

**"invalid committer" error:**
Your Git email doesn't match your typo3.org account. Register it at https://review.typo3.org/settings/#Identities

**"no new changes" error:**
You're trying to push an unchanged commit. Amend it to create a new SHA:

```bash
git commit --amend --allow-empty
```

**Change-Id missing:**
The commit-msg hook wasn't installed. Set it up and amend your commit.

---

*Welcome to the TYPO3 contributor community! Every patch makes a difference.*
