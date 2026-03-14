---
name: superpowers-subagent-dev
description: Use when executing implementation plans with independent tasks in the current session
---

# Subagent-Driven Development

Execute plan by dispatching fresh subagent per task, with two-stage review after each: spec compliance review first, then code quality review.

**Why subagents:** You delegate tasks to specialized agents with isolated context. By precisely crafting their instructions and context, you ensure they stay focused and succeed at their task.

**Core principle:** Fresh subagent per task + two-stage review (spec then quality) = high quality, fast iteration

## When to Use

- Have implementation plan with mostly independent tasks
- Want to stay in current session
- Subagents are available (Claude Code Task tool)

**vs. Executing Plans:** Same session, fresh subagent per task, two-stage review, faster iteration.

## The Process

For each task:

1. **Dispatch implementer subagent** with full task text + context
2. Handle implementer questions if any
3. Implementer implements, tests, commits, self-reviews
4. **Dispatch spec reviewer subagent** - verify code matches spec
5. If issues found → implementer fixes → re-review
6. **Dispatch code quality reviewer subagent** - verify implementation quality
7. If issues found → implementer fixes → re-review
8. Mark task complete

After all tasks: dispatch final code reviewer for entire implementation.

## Model Selection

- **Mechanical tasks** (isolated, clear specs, 1-2 files): use haiku (fast, cheap)
- **Integration tasks** (multi-file, pattern matching): use sonnet
- **Architecture/design/review**: use opus (most capable)

## Handling Implementer Status

- **DONE:** Proceed to spec compliance review
- **DONE_WITH_CONCERNS:** Read concerns, address if needed, then review
- **NEEDS_CONTEXT:** Provide missing context, re-dispatch
- **BLOCKED:** Assess blocker - more context, more capable model, or break task down

## Implementer Prompt Template

```
You are implementing Task N: [task name]

## Task Description
[FULL TEXT of task from plan]

## Context
[Scene-setting: where this fits, dependencies]

## Before You Begin
If you have questions, ask them now.

## Your Job
1. Implement exactly what the task specifies
2. Write tests (following TDD if task says to)
3. Verify implementation works
4. Commit your work
5. Self-review
6. Report back with status: DONE | DONE_WITH_CONCERNS | BLOCKED | NEEDS_CONTEXT
```

## Spec Reviewer Prompt Template

```
You are reviewing whether an implementation matches its specification.

## What Was Requested
[FULL TEXT of task requirements]

## CRITICAL: Do Not Trust the Report
Verify everything independently by reading actual code.

Report:
- ✅ Spec compliant
- ❌ Issues found: [list what's missing or extra]
```

## Red Flags

**Never:**

- Skip reviews (spec compliance OR code quality)
- Dispatch multiple implementation subagents in parallel
- Make subagent read plan file (provide full text instead)
- Accept "close enough" on spec compliance
- Start code quality review before spec compliance is ✅
