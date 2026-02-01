# Command Reference

Quick reference for common TYPO3 contribution commands.

## DDEV Commands

| Command | Description |
|---------|-------------|
| `ddev start` | Start the environment |
| `ddev stop` | Stop the environment |
| `ddev restart` | Restart containers |
| `ddev ssh` | SSH into web container |
| `ddev launch` | Open site in browser |
| `ddev launch typo3` | Open TYPO3 backend |
| `ddev logs` | View container logs |
| `ddev describe` | Show project info |
| `ddev poweroff` | Stop all DDEV projects |

## TYPO3 Commands

| Command | Description |
|---------|-------------|
| `ddev typo3 cache:flush` | Clear all caches |
| `ddev typo3 cache:warmup` | Warm up caches |
| `ddev typo3 extension:setup` | Set up extensions |
| `ddev typo3 extension:activate EXT` | Activate an extension |

## Test Runner Commands

| Command | Description |
|---------|-------------|
| `./Build/Scripts/runTests.sh -s composerInstall` | Install dependencies |
| `./Build/Scripts/runTests.sh -s cgl` | Fix code style |
| `./Build/Scripts/runTests.sh -s unit` | Run unit tests |
| `./Build/Scripts/runTests.sh -s functional` | Run functional tests |
| `./Build/Scripts/runTests.sh -s clean` | Clean build artifacts |
| `./Build/Scripts/runTests.sh -h` | Show all options |

## Git Commands

| Command | Description |
|---------|-------------|
| `git push origin HEAD:refs/for/main` | Push to Gerrit |
| `git push origin HEAD:refs/for/main%wip` | Push as WIP |
| `git commit --amend` | Update existing commit |
| `git reset --hard origin/main` | Reset to upstream |
| `git fetch --all` | Fetch all remotes |

## Cherry-Pick a Patch

```bash
git fetch https://review.typo3.org/Packages/TYPO3.CMS \
  refs/changes/XX/XXXXX/Y && git cherry-pick FETCH_HEAD
```

Replace `XX/XXXXX/Y` with the change number from Gerrit.

## Full Environment Update

```bash
./Build/Scripts/runTests.sh -s clean && \
git fetch --all && \
git reset --hard origin/main && \
./Build/Scripts/runTests.sh -s composerInstall && \
ddev typo3 cache:flush && \
ddev typo3 extension:setup
```

## Commit Message Template

```
[TYPE] Subject line (max 52 chars)

Description of what the change does.
Wrap at 72 characters.

Resolves: #ISSUE_NUMBER
Releases: main
```

**Types:** `[BUGFIX]`, `[FEATURE]`, `[TASK]`, `[DOCS]`, `[CLEANUP]`
