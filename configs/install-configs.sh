#!/bin/bash
#
# TYPO3 Contribution Setup Script
# https://dkd-dobberkau.github.io/contribute-to-typo3/
#

set -e

ORANGE='\033[0;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${ORANGE}"
echo "╔═══════════════════════════════════════════════════════╗"
echo "║       TYPO3 Core Contribution Setup Script            ║"
echo "╚═══════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check if we're in a TYPO3 clone
if [ ! -f "Build/Scripts/runTests.sh" ]; then
    echo -e "${RED}Error: This doesn't look like a TYPO3 repository.${NC}"
    echo "Please run this script from inside a TYPO3 clone:"
    echo ""
    echo "  git clone https://github.com/typo3/typo3.git ~/TYPO3-Contribution"
    echo "  cd ~/TYPO3-Contribution"
    echo "  curl -sL https://dkd-dobberkau.github.io/contribute-to-typo3/install.sh | bash"
    exit 1
fi

# Get user info
echo "Please enter your TYPO3.org details:"
echo ""
read -p "TYPO3 Username: " TYPO3_USERNAME
read -p "Full Name: " FULL_NAME
read -p "Email (same as typo3.org account): " EMAIL

echo ""
echo "Configuring Git..."

# Set git identity
git config user.name "$FULL_NAME"
git config user.email "$EMAIL"
echo -e "  ${GREEN}✓${NC} Set user.name and user.email"

# Set Gerrit push URL
git remote set-url --push origin "ssh://${TYPO3_USERNAME}@review.typo3.org:29418/Packages/TYPO3.CMS.git"
echo -e "  ${GREEN}✓${NC} Configured Gerrit push URL"

# Enable auto-rebase
git config branch.autosetuprebase remote
echo -e "  ${GREEN}✓${NC} Enabled auto-rebase"

# Install hooks
echo ""
echo "Installing Git hooks..."
mkdir -p .git/hooks

if [ -f "Build/git-hooks/commit-msg" ]; then
    cp Build/git-hooks/commit-msg .git/hooks/
    chmod +x .git/hooks/commit-msg
    echo -e "  ${GREEN}✓${NC} Installed commit-msg hook"
else
    echo -e "  ${ORANGE}!${NC} commit-msg hook not found in Build/git-hooks/"
fi

if [ -f "Build/git-hooks/pre-commit" ]; then
    cp Build/git-hooks/pre-commit .git/hooks/
    chmod +x .git/hooks/pre-commit
    echo -e "  ${GREEN}✓${NC} Installed pre-commit hook"
fi

# Create commit template
echo ""
echo "Creating commit template..."
TEMPLATE_PATH="$HOME/.gitmessage-typo3.txt"
cat > "$TEMPLATE_PATH" << 'EOF'
[BUGFIX|TASK|FEATURE|DOCS] Subject line (max 52 chars)

Description of what the change does.
Wrap lines at 72 characters.

Resolves: #
Releases: main
EOF
git config commit.template "$TEMPLATE_PATH"
echo -e "  ${GREEN}✓${NC} Created $TEMPLATE_PATH"

# Ask about DDEV
echo ""
read -p "Do you want to initialize DDEV? (y/N): " INIT_DDEV
if [[ "$INIT_DDEV" =~ ^[Yy]$ ]]; then
    echo ""
    echo "Configuring DDEV..."
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
    echo -e "  ${GREEN}✓${NC} DDEV configured"
fi

echo ""
echo -e "${GREEN}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                  Setup Complete!                      ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════╝${NC}"
echo ""
echo "Next steps:"
echo "  1. ddev start"
echo "  2. ./Build/Scripts/runTests.sh -s composerInstall"
echo "  3. Set up TYPO3 (see documentation)"
echo ""
echo "Documentation: https://dkd-dobberkau.github.io/contribute-to-typo3/"
echo ""
