---
name: superpowers-git-worktrees
description: Use when starting feature work that needs isolation from current workspace or before executing implementation plans
---

# Using Git Worktrees

Git worktrees create isolated workspaces sharing the same repository.

**Core principle:** Systematic directory selection + safety verification = reliable isolation.

## Directory Selection Process

1. **Check existing:** `.worktrees/` or `worktrees/` directories
2. **Check CLAUDE.md** for worktree preferences
3. **Ask user** if nothing found

## Safety Verification

For project-local directories: MUST verify directory is in .gitignore before creating worktree.

```bash
git check-ignore -q .worktrees 2>/dev/null
```

If NOT ignored: add to .gitignore and commit.

## Creation Steps

```bash
# 1. Detect project name
project=$(basename "$(git rev-parse --show-toplevel)")

# 2. Create worktree with new branch
git worktree add "$path" -b "$BRANCH_NAME"
cd "$path"

# 3. Run project setup (auto-detect)
# Node.js: npm install / pnpm install
# Rust: cargo build
# Python: pip install -r requirements.txt
# Go: go mod download

# 4. Verify clean baseline
# Run tests to ensure worktree starts clean

# 5. Report location
```

## Quick Reference

| Situation                  | Action                     |
| -------------------------- | -------------------------- |
| `.worktrees/` exists       | Use it (verify ignored)    |
| `worktrees/` exists        | Use it (verify ignored)    |
| Neither exists             | Check CLAUDE.md → Ask user |
| Directory not ignored      | Add to .gitignore + commit |
| Tests fail during baseline | Report failures + ask      |

## Red Flags

- Never create worktree without verifying it's ignored
- Never skip baseline test verification
- Never proceed with failing tests without asking
- Always follow directory priority: existing > CLAUDE.md > ask
