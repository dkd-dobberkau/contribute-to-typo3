# Review Process

**Goal:** Understand how Gerrit reviews work and how to review others' patches.

## How Gerrit Voting Works

Patches require approval votes before merging:

| Vote Type | Values | Who Can Vote |
|-----------|--------|--------------|
| **Code-Review** | -2 to +2 | Anyone (+2 requires Core Team) |
| **Verified** | -1 to +1 | Anyone |

### Requirements for Merge

- At least **2 people** verified (+1 Verified each)
- At least **2 people** reviewed code (one must be Core Team with +2)
- Core CI passes (+1)

## Understanding Vote Values

### Code-Review

| Vote | Meaning |
|------|---------|
| +2 | Approved (Core Team only) |
| +1 | Looks good to me |
| 0 | No opinion |
| -1 | Needs changes |
| -2 | Blocks merge |

### Verified

| Vote | Meaning |
|------|---------|
| +1 | Tested and works |
| 0 | Not tested |
| -1 | Tested, doesn't work |

## Reviewing Others' Patches

Contributing reviews is valuable and helps you learn the codebase.

### Find Patches to Review

- [Gerrit](https://review.typo3.org) - Open changes
- [Forger](https://forger.typo3.com) - Search with filters

### Test a Patch Locally

1. Find the cherry-pick command on the Gerrit review page
2. Run it in your TYPO3 directory:

```bash
git fetch https://review.typo3.org/Packages/TYPO3.CMS \
  refs/changes/XX/XXXXX/Y && git cherry-pick FETCH_HEAD
```

3. Test the functionality
4. Vote and comment in Gerrit

### What to Check

- Does the code follow TYPO3 Coding Guidelines?
- Does the change do what the issue describes?
- Are there tests for the change?
- Does it break existing functionality?
- Is the commit message properly formatted?

## After Your Patch is Merged

Congratulations! Clean up your local branch:

```bash
git fetch origin
git reset --hard origin/main
```

## Keeping Your Environment Updated

Regularly sync with upstream:

```bash
./Build/Scripts/runTests.sh -s clean
git fetch --all
git reset --hard origin/main
./Build/Scripts/runTests.sh -s composerInstall
ddev typo3 cache:flush
ddev typo3 extension:setup
```

## Next Step

Need help? Check [Troubleshooting](troubleshooting.md) for common issues.
