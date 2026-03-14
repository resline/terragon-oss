---
name: superpowers-code-review-request
description: Use when completing tasks, implementing major features, or before merging to verify work meets requirements
---

# Requesting Code Review

Dispatch code-reviewer subagent to catch issues before they cascade.

**Core principle:** Review early, review often.

## When to Request Review

**Mandatory:**

- After each task in subagent-driven development
- After completing major feature
- Before merge to main

**Optional but valuable:**

- When stuck (fresh perspective)
- Before refactoring (baseline check)
- After fixing complex bug

## How to Request

1. Get git SHAs:

```bash
BASE_SHA=$(git rev-parse HEAD~1)
HEAD_SHA=$(git rev-parse HEAD)
```

2. Dispatch code-reviewer subagent with:

- What was implemented
- Plan or requirements reference
- Base and head SHAs
- Brief description

3. Act on feedback:

- **Critical:** Fix immediately
- **Important:** Fix before proceeding
- **Minor:** Note for later
- Push back if reviewer is wrong (with reasoning)
