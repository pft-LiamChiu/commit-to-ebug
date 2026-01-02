# git-ebug

A lightweight git subcommand that automatically sends commit metadata to n8n webhooks when your commit message starts with `[what] ebug:`.

Built for simplicity, local-first workflows, and easy team collaboration.

---

## Prerequisites

- **git**
- **bash**
- **curl**

**Windows users:** Use Git Bash or WSL (PowerShell/cmd not supported)

---

## Quick Start

### Installation

```bash
git clone <REPO_URL>
cd git-ebug
./install.sh
```

Verify the installation:

```bash
git ebug --help
```

### Configuration

The installer creates a config file at `~/.local/bin/.env.n8n`. Edit it and add:

```bash
N8N_URL="xxx"
N8N_SECRET="xxx"
HMAC_SECRET="xxx"
U_MESSENGER_EMAIL="xxx"
```

**Security:** Restrict file permissions to owner only:

```bash
chmod 600 ~/.local/bin/.env.n8n
```

---

## Usage

Send the latest commit:

```bash
git ebug
```

Send a specific commit:

```bash
git ebug <commit-hash>
```

---

## How It Works

Commits with messages starting with `[what] ebug:` automatically trigger webhook notifications to your configured n8n instance.

## Commit Message Format Must Be:

```
[what] ebug:xxx

[why]

[how]

@reviewer
```
