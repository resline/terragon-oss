---
name: refactor
description: "Use when the user writes 'refactor' - activates safe refactoring mode. Focuses on improving code structure without changing behavior. Uses incremental steps with verification at each stage to prevent regressions."
---

# Refactor Mode

## Overview

Safe, methodical code refactoring. Every change preserves existing behavior while improving code structure, readability, and maintainability. Uses small, verifiable steps.

## When to Use

**TRIGGER:** User explicitly writes "refactor" in their request.

## Golden Rules

1. **Never change behavior** - refactoring is about structure, not functionality
2. **Small steps** - each change should be independently verifiable
3. **Verify after each step** - run type checks and tests between changes
4. **Commit often** - save progress at each successful step

## Process

### Phase 1: Understand

- Read ALL code that will be affected
- Identify the current behavior and all callers/consumers
- Map the dependency graph
- Run existing tests to establish a baseline

### Phase 2: Plan

- Define the target structure
- Break the refactoring into atomic steps
- Identify risk points and verification strategies
- Order steps to minimize intermediate breakage

### Phase 3: Execute

For each step:

1. Make the change
2. Run `pnpm tsc-check` to verify types
3. Run relevant tests
4. If anything breaks, revert and try a smaller step

### Phase 4: Verify

- Run full type check: `pnpm tsc-check`
- Run tests: `pnpm -C apps/www test`
- Verify no unused imports or dead code remain
- Check that all callers/consumers still work correctly

## Common Refactoring Patterns

| Pattern                                   | When to Use                                 |
| ----------------------------------------- | ------------------------------------------- |
| **Extract function**                      | Logic block is too complex or reused        |
| **Extract component**                     | UI section is too complex or reused         |
| **Move to shared**                        | Logic is used across multiple apps/packages |
| **Rename**                                | Name doesn't clearly convey purpose         |
| **Inline**                                | Abstraction adds complexity without value   |
| **Replace conditional with polymorphism** | Complex switch/if chains                    |
| **Extract type/interface**                | Type is complex or shared                   |

## Terragon-Specific Notes

- Shared code goes in `packages/shared/`
- UI components in `apps/www/src/components/`
- Server actions in `apps/www/src/server-actions/`
- Use `workspace:*` for cross-package imports
- Run `pnpm tsc-check` after any structural change

## Context Compaction

When summarizing context, ALWAYS include:

```
TRYB PRACY: refactor - kontynuuj bezpieczne refaktoryzowanie kodu
```
