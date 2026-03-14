---
name: superpowers-writing-plans
description: Use when you have a spec or requirements for a multi-step task, before touching code
---

# Writing Plans

## Overview

Write comprehensive implementation plans assuming the engineer has zero context for our codebase. Document everything they need to know: which files to touch, code, testing, docs, how to test. Give them the whole plan as bite-sized tasks. DRY. YAGNI. TDD. Frequent commits.

**Save plans to:** `docs/superpowers/plans/YYYY-MM-DD-<feature-name>.md`

## Bite-Sized Task Granularity

Each step is one action (2-5 minutes):

- "Write the failing test" - step
- "Run it to make sure it fails" - step
- "Implement the minimal code to make the test pass" - step
- "Run the tests and make sure they pass" - step
- "Commit" - step

## Plan Document Header

Every plan MUST start with:

```markdown
# [Feature Name] Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers-subagent-dev (if subagents available) or superpowers-executing-plans to implement this plan.

**Goal:** [One sentence]
**Architecture:** [2-3 sentences]
**Tech Stack:** [Key technologies]
```

## Task Structure

Each task includes:

- **Files:** Create/Modify/Test with exact paths
- **Steps:** Checkbox syntax (`- [ ]`) for tracking
- **Code:** Complete code in plan (not "add validation")
- **Commands:** Exact commands with expected output

## Plan Review Loop

After each chunk:

1. Dispatch plan-document-reviewer subagent
2. If issues found → fix → re-dispatch
3. If approved → proceed

## Execution Handoff

**If subagents available:** Use superpowers-subagent-dev (REQUIRED)
**If no subagents:** Use superpowers-executing-plans
