# Troubleshooting

**Goal:** Fix common issues when contributing to TYPO3.

## SSH & Authentication

### "Permission denied (publickey)"

Your SSH key isn't recognized by Gerrit.

**Fix:**

1. Check your key is loaded:
   ```bash
   ssh-add -l
   ```

2. Verify your public key is in Gerrit:
   - Go to [review.typo3.org](https://review.typo3.org) → Settings → SSH Keys

3. Test the connection:
   ```bash
   ssh -p 29418 YOUR_USERNAME@review.typo3.org
   ```

### "invalid committer"

Your Git email doesn't match your typo3.org account.

**Fix:**

1. Register additional emails at [review.typo3.org/settings/#Identities](https://review.typo3.org/settings/#Identities)

2. Or update your local Git config:
   ```bash
   git config user.email "your.registered@email.com"
   ```

## Git & Gerrit

### "no new changes"

You're pushing an unchanged commit.

**Fix:** Amend the commit to create a new SHA:

```bash
git commit --amend --no-edit
git push origin HEAD:refs/for/main
```

### "Change-Id missing"

The commit-msg hook wasn't installed or didn't run.

**Fix:**

1. Install the hook:
   ```bash
   cp Build/git-hooks/commit-msg .git/hooks/
   chmod +x .git/hooks/commit-msg
   ```

2. Amend your commit (the hook adds the Change-Id):
   ```bash
   git commit --amend --no-edit
   ```

### "not permitted: update"

You don't have permission to push to this branch.

**Fix:** Make sure you're pushing to Gerrit, not GitHub:

```bash
git remote get-url --push origin
# Should show: ssh://YOUR_USERNAME@review.typo3.org:29418/Packages/TYPO3.CMS.git
```

## DDEV & Environment

### "port already in use"

Another service is using ports 80/443.

**Fix:**

```bash
ddev poweroff
# Stop other services using these ports
ddev start
```

Or use different ports in `.ddev/config.yaml`:

```yaml
router_http_port: "8080"
router_https_port: "8443"
```

### Database connection failed

DDEV containers aren't running.

**Fix:**

```bash
ddev restart
ddev typo3 setup --force
```

### Composer install fails

**Fix:** Use the runTests.sh script instead:

```bash
./Build/Scripts/runTests.sh -s composerInstall
```

## Getting Help

Still stuck?

- **Slack**: [#typo3-cms-coredev](https://typo3.slack.com) - Friendly community help
- **Documentation**: [Official Contribution Guide](https://docs.typo3.org/core-contribution)
- **Forge**: Search existing issues at [forge.typo3.org](https://forge.typo3.org)
