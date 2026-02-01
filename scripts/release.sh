#!/bin/bash
#
# Release script for contribute-to-typo3
# Creates a new release with version tag and changelog entry
#

set -e

ORANGE='\033[0;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${ORANGE}"
echo "╔═══════════════════════════════════════════════════════╗"
echo "║          contribute-to-typo3 Release Script           ║"
echo "╚═══════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check we're in the right directory
if [ ! -f "mkdocs.yml" ]; then
    echo -e "${RED}Error: Must be run from the project root directory.${NC}"
    exit 1
fi

# Check for uncommitted changes
if ! git diff-index --quiet HEAD --; then
    echo -e "${RED}Error: You have uncommitted changes. Please commit or stash them first.${NC}"
    git status --short
    exit 1
fi

# Get current version (latest tag)
CURRENT_VERSION=$(git describe --tags --abbrev=0 2>/dev/null || echo "none")
echo -e "${BLUE}Current version:${NC} ${CURRENT_VERSION}"

# Get new version
echo ""
read -p "Enter new version (e.g., 1.0.0): v" NEW_VERSION

if [ -z "$NEW_VERSION" ]; then
    echo -e "${RED}Error: Version cannot be empty.${NC}"
    exit 1
fi

# Validate semver format
if ! [[ "$NEW_VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo -e "${RED}Error: Version must be in semver format (e.g., 1.0.0).${NC}"
    exit 1
fi

TAG="v${NEW_VERSION}"

# Check if tag already exists
if git rev-parse "$TAG" >/dev/null 2>&1; then
    echo -e "${RED}Error: Tag ${TAG} already exists.${NC}"
    exit 1
fi

# Get release notes
echo ""
echo -e "${BLUE}Enter release notes (press Ctrl+D when done):${NC}"
RELEASE_NOTES=$(cat)

if [ -z "$RELEASE_NOTES" ]; then
    echo -e "${RED}Error: Release notes cannot be empty.${NC}"
    exit 1
fi

# Update CHANGELOG.md
CHANGELOG_FILE="CHANGELOG.md"
DATE=$(date +%Y-%m-%d)

if [ ! -f "$CHANGELOG_FILE" ]; then
    cat > "$CHANGELOG_FILE" << 'HEADER'
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

HEADER
fi

# Create new changelog entry
TEMP_FILE=$(mktemp)
{
    head -n 7 "$CHANGELOG_FILE"
    echo ""
    echo "## [${NEW_VERSION}] - ${DATE}"
    echo ""
    echo "$RELEASE_NOTES"
    echo ""
    tail -n +8 "$CHANGELOG_FILE"
} > "$TEMP_FILE"

mv "$TEMP_FILE" "$CHANGELOG_FILE"

echo ""
echo -e "${GREEN}✓${NC} Updated CHANGELOG.md"

# Commit changelog
git add "$CHANGELOG_FILE"
git commit -m "docs: update changelog for ${TAG}"

echo -e "${GREEN}✓${NC} Committed changelog update"

# Create annotated tag
git tag -a "$TAG" -m "Release ${TAG}

${RELEASE_NOTES}"

echo -e "${GREEN}✓${NC} Created tag ${TAG}"

# Confirm push
echo ""
echo -e "${ORANGE}Ready to push to GitHub:${NC}"
echo "  - Commit: docs: update changelog for ${TAG}"
echo "  - Tag: ${TAG}"
echo ""
read -p "Push to origin? (y/N): " CONFIRM_PUSH

if [[ "$CONFIRM_PUSH" =~ ^[Yy]$ ]]; then
    git push origin main
    git push origin "$TAG"
    echo ""
    echo -e "${GREEN}✓${NC} Pushed to GitHub"

    # Create GitHub release
    echo ""
    read -p "Create GitHub release? (y/N): " CONFIRM_RELEASE

    if [[ "$CONFIRM_RELEASE" =~ ^[Yy]$ ]]; then
        gh release create "$TAG" \
            --title "Release ${TAG}" \
            --notes "$RELEASE_NOTES"
        echo -e "${GREEN}✓${NC} Created GitHub release"
    fi
else
    echo ""
    echo -e "${ORANGE}Skipped push. To push manually:${NC}"
    echo "  git push origin main"
    echo "  git push origin ${TAG}"
fi

echo ""
echo -e "${GREEN}╔═══════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║              Release ${TAG} complete!               ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════════════════════╝${NC}"
echo ""
echo "View release: https://github.com/dkd-dobberkau/contribute-to-typo3/releases/tag/${TAG}"
echo "Documentation: https://dkd-dobberkau.github.io/contribute-to-typo3/"
echo ""
