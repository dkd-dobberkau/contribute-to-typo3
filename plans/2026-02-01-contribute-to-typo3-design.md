# Design: contribute-to-typo3 Starter Kit

**Date**: 2026-02-01
**Status**: Approved
**Repository**: `dkd-dobberkau/contribute-to-typo3`
**URL**: `https://dkd-dobberkau.github.io/contribute-to-typo3/`

## Overview

A GitHub repository with MkDocs Material documentation site that guides developers through setting up a TYPO3 Core contribution environment. Combines step-by-step documentation with helper scripts for complex configuration tasks.

## Decisions

| Aspect | Decision |
|--------|----------|
| Approach | Hybrid: documentation + helper scripts |
| Framework | MkDocs Material |
| Deployment | GitHub Pages via GitHub Actions |
| Theme | TYPO3 brand colors (deep orange) |
| Config delivery | Downloadable bundle + install script |

## Repository Structure

```
contribute-to-typo3/
├── docs/                          # MkDocs source files
│   ├── index.md                   # Welcome & overview
│   ├── prerequisites.md           # Required tools
│   ├── accounts.md                # TYPO3.org, Gerrit, Forge setup
│   ├── clone-and-configure.md     # Git clone & configuration
│   ├── ddev-setup.md              # DDEV environment
│   ├── typo3-install.md           # TYPO3 installation
│   ├── contribution-workflow.md   # Making & submitting patches
│   ├── review-process.md          # Gerrit voting & reviewing others
│   ├── troubleshooting.md         # Common pitfalls & fixes
│   └── reference.md               # Quick command reference
├── configs/                       # Downloadable config bundle
│   ├── .ddev/
│   │   └── config.yaml            # Pre-configured DDEV settings
│   ├── git-hooks/
│   │   ├── commit-msg             # Gerrit Change-Id hook
│   │   └── pre-commit             # Code style check
│   ├── .gitmessage.txt            # Commit template
│   └── install-configs.sh         # Copy script
├── mkdocs.yml                     # MkDocs configuration
├── requirements.txt               # mkdocs-material dependency
├── README.md                      # Repo overview + quick start
└── .github/
    └── workflows/
        └── deploy.yml             # GitHub Actions for Pages
```

## Site Navigation

```yaml
nav:
  - Home: index.md
  - Getting Started:
    - Prerequisites: prerequisites.md
    - Create Accounts: accounts.md
  - Setup:
    - Clone & Configure Git: clone-and-configure.md
    - DDEV Environment: ddev-setup.md
    - Install TYPO3: typo3-install.md
  - Contributing:
    - Contribution Workflow: contribution-workflow.md
    - Review Process: review-process.md
  - Help:
    - Troubleshooting: troubleshooting.md
    - Command Reference: reference.md
```

## Install Script Behavior

**configs/install-configs.sh**:

1. Prompts for TYPO3 username and email
2. Validates running inside a TYPO3 clone
3. Copies git hooks to `.git/hooks/`
4. Creates commit template at `~/.gitmessage-typo3.txt`
5. Configures git: user.name, user.email, Gerrit push URL
6. Optionally creates `.ddev/config.yaml`

**One-liner usage:**
```bash
curl -sL https://dkd-dobberkau.github.io/contribute-to-typo3/install.sh | bash
```

## Documentation Page Pattern

Each page follows:

1. **Goal** - One sentence describing what you'll accomplish
2. **Steps** - Numbered steps with copyable code blocks
3. **Verify** - How to confirm the step worked
4. **Next** - Link to the next page

## Content Sources

Based on `/Users/olivier/Versioncontrol/local/contribute-1O1/TYPO3-Core-Contribution-Howto.md` and official TYPO3 Contribution Guide at https://docs.typo3.org/core-contribution

## Implementation Tasks

1. Initialize git repo
2. Create MkDocs configuration
3. Set up GitHub Actions workflow
4. Write documentation pages (10 pages)
5. Create config bundle files
6. Write install-configs.sh script
7. Create GitHub repo and push
8. Enable GitHub Pages
9. Test the full flow
