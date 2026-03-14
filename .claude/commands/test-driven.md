---
name: test-driven
description: "Use when the user writes 'test-driven' - activates TDD mode. Write tests first, then implement code to pass them. Uses Vitest for this project. Ensures high coverage of critical paths."
---

# Test-Driven Development Mode

## Overview

Write tests first, then implement. Every feature starts with a failing test that defines the expected behavior, then the minimal code to make it pass, then refactoring.

## When to Use

**TRIGGER:** User explicitly writes "test-driven" in their request.

## Process (Red-Green-Refactor)

### 1. RED: Write a Failing Test

- Define the expected behavior in a test
- Run the test to confirm it fails
- The test failure message should clearly describe what's missing

### 2. GREEN: Write Minimal Code

- Write the simplest code that makes the test pass
- Don't over-engineer or add unrequested features
- Run the test to confirm it passes

### 3. REFACTOR: Improve the Code

- Clean up the implementation while keeping tests green
- Extract shared logic if patterns emerge
- Run all tests to ensure nothing broke

## Testing Stack (Terragon)

| Tool                | Usage                             |
| ------------------- | --------------------------------- |
| **Vitest**          | Test runner and assertion library |
| **Testing Library** | React component testing           |
| **MSW**             | API mocking                       |

## Commands

```bash
# Run tests for the main app
pnpm -C apps/www test

# Run tests for shared package
pnpm -C packages/shared test

# Run tests for daemon
pnpm -C packages/daemon test

# Run tests for sandbox
pnpm -C packages/sandbox test

# Run specific test file
pnpm -C apps/www vitest run path/to/test.test.ts
```

## Test File Conventions

- Test files: `*.test.ts` or `*.test.tsx`
- Colocate tests with source: `component.tsx` → `component.test.tsx`
- Or use `__tests__/` directory for complex test suites
- Use descriptive test names: `it("should return error when user is not authenticated")`

## What to Test

| Priority   | What             | How                                     |
| ---------- | ---------------- | --------------------------------------- |
| **High**   | Server Actions   | Mock DB, test input validation and auth |
| **High**   | Business logic   | Pure function unit tests                |
| **Medium** | React hooks      | Testing Library renderHook              |
| **Medium** | API integrations | MSW for mocking external services       |
| **Low**    | UI components    | Snapshot + interaction tests            |

## Context Compaction

When summarizing context, ALWAYS include:

```
TRYB PRACY: test-driven - kontynuuj pracę w trybie TDD
```
