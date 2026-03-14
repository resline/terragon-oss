---
name: debug-detective
description: "Use when the user writes 'debug-detective' - activates systematic debugging mode. Methodically investigates bugs through hypothesis-driven analysis, log tracing, and root cause identification. Never guesses - always verifies."
---

# Debug Detective Mode

## Overview

Systematic, methodical debugging approach. Instead of guessing at fixes, follow a disciplined investigation process to identify root causes before applying solutions.

## When to Use

**TRIGGER:** User explicitly writes "debug-detective" in their request.

## Process

### Step 1: Reproduce

- Understand the expected vs actual behavior
- Identify the exact conditions to reproduce the bug
- Check if the issue is consistent or intermittent

### Step 2: Isolate

- Narrow down the affected code paths
- Identify the most recent change that could have introduced the bug
- Use `git log` and `git diff` to trace changes
- Binary search through commits if needed

### Step 3: Hypothesize

- Form 2-3 hypotheses about the root cause
- Rank them by likelihood
- Design a test for each hypothesis

### Step 4: Investigate

- Read ALL relevant code paths (don't skip)
- Trace data flow from input to output
- Check for:
  - Race conditions
  - State mutations
  - Null/undefined values
  - Type mismatches
  - Off-by-one errors
  - Async timing issues
  - Environment differences

### Step 5: Verify & Fix

- Confirm the root cause with evidence
- Apply the minimal fix that addresses the root cause
- Verify the fix doesn't introduce new issues
- Check for similar patterns elsewhere in the codebase

## Debugging Toolkit (Terragon)

| Area         | Tools                                                             |
| ------------ | ----------------------------------------------------------------- |
| **Frontend** | Browser DevTools, React DevTools, Network tab                     |
| **Server**   | Server logs, `console.log` with structured data                   |
| **Database** | Drizzle Studio (`pnpm -C packages/shared drizzle-kit-studio-dev`) |
| **Types**    | `pnpm tsc-check` for TypeScript errors                            |
| **Tests**    | `pnpm -C apps/www test` for unit/integration tests                |
| **Git**      | `git log --oneline`, `git bisect`, `git diff`                     |

## Anti-Patterns (Avoid)

- Changing code randomly hoping to fix the issue
- Adding try/catch blocks to hide errors
- Fixing symptoms instead of root causes
- Skipping reproduction steps
- Assuming the bug is in one specific place without verification

## Context Compaction

When summarizing context, ALWAYS include:

```
TRYB PRACY: debug-detective - kontynuuj systematyczne debugowanie
```
