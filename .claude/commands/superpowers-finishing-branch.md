---
name: superpowers-finishing-branch
description: Use when implementation is complete, all tests pass, and you need to decide how to integrate the work - guides completion of development work
---

# Finishing a Development Branch

## The Process

### Step 1: Verify Tests

Run project's test suite. If tests fail → STOP. Cannot proceed.

### Step 2: Determine Base Branch

```bash
git merge-base HEAD main 2>/dev/null || git merge-base HEAD master 2>/dev/null
```

### Step 3: Present Options

Present exactly 4 options:

1. Merge back to base-branch locally
2. Push and create a Pull Request
3. Keep the branch as-is
4. Discard this work

### Step 4: Execute Choice

**Option 1 (Merge):** checkout base → pull → merge → verify tests → delete branch
**Option 2 (PR):** push with -u → `gh pr create` → report URL
**Option 3 (Keep):** Report branch name and location
**Option 4 (Discard):** Require typed "discard" confirmation → delete branch

### Step 5: Cleanup Worktree (Options 1, 2, 4)

```bash
git worktree remove <worktree-path>
```

## Red Flags

- Never proceed with failing tests
- Never merge without verifying tests on result
- Never delete work without confirmation
- Never force-push without explicit request
