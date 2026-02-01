# Contribute to TYPO3

A getting-started guide for contributing to TYPO3 Core.

**Documentation:** https://dkd-dobberkau.github.io/contribute-to-typo3/

## Quick Start

1. **Clone TYPO3:**
   ```bash
   git clone https://github.com/typo3/typo3.git ~/TYPO3-Contribution
   cd ~/TYPO3-Contribution
   ```

2. **Run setup script:**
   ```bash
   curl -sL https://dkd-dobberkau.github.io/contribute-to-typo3/install.sh | bash
   ```

3. **Start environment:**
   ```bash
   ddev start
   ./Build/Scripts/runTests.sh -s composerInstall
   ```

4. **Read the full guide** at https://dkd-dobberkau.github.io/contribute-to-typo3/

## What's Included

- Step-by-step documentation for TYPO3 Core contribution
- Interactive setup script for Git/Gerrit configuration
- DDEV configuration template
- Git hooks and commit message template

## Local Development

Preview the documentation locally:

```bash
pip install -r requirements.txt
mkdocs serve
```

## License

MIT License - Feel free to use and adapt.

## Credits

This guide is based on the [Official TYPO3 Contribution Guide](https://docs.typo3.org/core-contribution) maintained by the [TYPO3 Documentation Team](https://typo3.org/community/teams/documentation). Thank you to all contributors who make TYPO3 documentation excellent.

## Resources

- [Official TYPO3 Contribution Guide](https://docs.typo3.org/core-contribution)
- [TYPO3 Slack](https://typo3.slack.com)
- [Forge Issue Tracker](https://forge.typo3.org/projects/typo3cms-core/issues)
- [Gerrit Code Review](https://review.typo3.org)

---

TYPO3 is a registered trademark of the [TYPO3 Association](https://typo3.org/project/association). See [The Brand](https://typo3.com/typo3-cms/the-brand) for trademark guidelines.
