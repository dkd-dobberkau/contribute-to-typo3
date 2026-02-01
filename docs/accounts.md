# Create Accounts

**Goal:** Set up your TYPO3.org account and configure SSH access for Gerrit.

## Step 1: Register at my.typo3.org

1. Go to [my.typo3.org](https://my.typo3.org)
2. Click "Register"
3. Use your **real name** and a valid email address
4. Verify your email via the confirmation link

!!! info "Single Sign-On"
    This one account gives you access to Forge, Gerrit, and all TYPO3 services.

## Step 2: Generate SSH Key (if needed)

Check if you already have an SSH key:

```bash
ls -la ~/.ssh/id_*.pub
```

If no key exists, generate one:

```bash
ssh-keygen -t ed25519 -C "your.email@example.com"
```

Press Enter to accept defaults. Copy the public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

## Step 3: Add SSH Key to Gerrit

1. Log into [review.typo3.org](https://review.typo3.org) with your typo3.org credentials
2. Click your avatar → **Settings**
3. Go to **SSH Keys** in the left menu
4. Click **Add new SSH key**
5. Paste your public key and save

## Step 4: Verify SSH Connection

Test your Gerrit access:

```bash
ssh -p 29418 YOUR_TYPO3_USERNAME@review.typo3.org
```

!!! success "Expected Output"
    ```
    ****    Welcome to Gerrit Code Review    ****

    Hi Your Name, you have successfully connected over SSH.
    ```

## Step 5: Join Slack (Recommended)

1. Go to [typo3.slack.com](https://typo3.slack.com)
2. Join the `#typo3-cms-coredev` channel

This is where the core team and contributors discuss patches and help each other.

## Next Step

[Clone & Configure Git](clone-and-configure.md) - Get the TYPO3 source code and configure Git.
