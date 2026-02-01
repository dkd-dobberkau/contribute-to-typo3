# Clone & Configure Git

**Goal:** Clone the TYPO3 repository and configure Git for Gerrit.

## Step 1: Clone the Repository

Create a working directory and clone TYPO3:

```bash
mkdir ~/TYPO3-Contribution
cd ~/TYPO3-Contribution
git clone https://github.com/typo3/typo3.git .
```

!!! note "Why the dot?"
    The `.` clones directly into the current directory instead of creating a `typo3` subfolder.

## Step 2: Run the Install Script

The easiest way to configure everything:

```bash
curl -sL https://dkd-dobberkau.github.io/contribute-to-typo3/install.sh | bash
```

This script will:

- Set your Git user.name and user.email
- Configure the Gerrit push URL
- Install commit-msg and pre-commit hooks
- Create a commit message template

**Or configure manually** (see below).

## Manual Configuration

### Set Git Identity

Use the same email as your typo3.org account:

```bash
git config user.name "Your Real Name"
git config user.email "your.email@example.com"
```

### Configure Gerrit Push URL

Replace `YOUR_TYPO3_USERNAME` with your actual username:

```bash
git remote set-url --push origin \
  ssh://YOUR_TYPO3_USERNAME@review.typo3.org:29418/Packages/TYPO3.CMS.git
```

### Enable Auto-Rebase

Avoid merge commits:

```bash
git config branch.autosetuprebase remote
```

### Install Git Hooks

The commit-msg hook adds the Change-Id required by Gerrit:

```bash
cp Build/git-hooks/commit-msg .git/hooks/
cp Build/git-hooks/pre-commit .git/hooks/
chmod +x .git/hooks/commit-msg .git/hooks/pre-commit
```

Or use Composer:

```bash
composer gerrit:setup
```

### Create Commit Template

```bash
cat > ~/.gitmessage-typo3.txt << 'EOF'
[BUGFIX|TASK|FEATURE|DOCS] Subject line (max 52 chars)

Description of what the change does.
Wrap lines at 72 characters.

Resolves: #
Releases: main
EOF

git config commit.template ~/.gitmessage-typo3.txt
```

## Verify Configuration

Check your setup:

```bash
git config --list --local | grep -E "(user|remote|commit)"
```

Expected output includes:

```
user.name=Your Real Name
user.email=your.email@example.com
remote.origin.pushurl=ssh://your-username@review.typo3.org:29418/Packages/TYPO3.CMS.git
commit.template=/Users/you/.gitmessage-typo3.txt
```

## Next Step

[DDEV Environment](ddev-setup.md) - Set up your local development environment.
