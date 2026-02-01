# Contribution Workflow

**Goal:** Learn how to create a patch and submit it for review.

## Step 1: Find or Create a Forge Issue

Every patch needs a matching Forge issue:

1. Search [Forge](https://forge.typo3.org/projects/typo3cms-core/issues) or [Forger](https://forger.typo3.com)
2. If no issue exists, create one with a clear description
3. Note the issue number (e.g., `#12345`)

## Step 2: Make Your Changes

!!! warning "Work on main"
    Always work directly on the `main` branch. Do **not** create feature branches.

1. Make your code changes
2. Follow the [TYPO3 Coding Guidelines](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/CodingGuidelines/)

### Fix Code Style Automatically

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

## Step 3: Commit Your Changes

Create a single, well-formatted commit:

```bash
git add .
git commit
```

### Commit Message Format

```
[TYPE] Subject line in imperative mood (max 52 chars)

Extended description explaining what the change does.
Wrap at 72 characters. Focus on what changed, not what
was broken (that belongs in the Forge issue).

Resolves: #12345
Releases: main
```

### Valid TYPE Keywords

| Type | Use For |
|------|---------|
| `[BUGFIX]` | Fixes a bug |
| `[FEATURE]` | Adds new functionality |
| `[TASK]` | Maintenance, refactoring, cleanup |
| `[DOCS]` | Documentation changes only |
| `[CLEANUP]` | Code cleanup without functional changes |

### Subject Line Rules

- Maximum 52 characters
- Use imperative mood ("Fix bug" not "Fixed bug")
- No period at the end
- Test: "If applied, this commit will [your subject]"

## Step 4: Push to Gerrit

```bash
git push origin HEAD:refs/for/main
```

Gerrit responds with a URL to your review.

### Push as Work-in-Progress

Not ready for review yet? Push as WIP:

```bash
git push origin HEAD:refs/for/main%wip
```

## Step 5: Update Your Patch

When reviewers request changes:

1. Make the required changes
2. Amend your commit (keeps the Change-Id):

```bash
git add .
git commit --amend
```

3. Push again:

```bash
git push origin HEAD:refs/for/main
```

## Next Step

[Review Process](review-process.md) - Understand how patches get reviewed and merged.
