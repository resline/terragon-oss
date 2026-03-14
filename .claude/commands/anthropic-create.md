---
name: anthropic-create
description: "Use when the user writes 'anthropic-create' - follows Anthropic's recommended patterns for creating new features, components, and modules. Emphasizes clean architecture, type safety, proper testing, and incremental implementation."
---

# Anthropic Create - Structured Feature Creation

## Overview

A structured approach to creating new features, components, and modules following best practices. Emphasizes incremental implementation with validation at each step.

## When to Use

**TRIGGER:** User explicitly writes "anthropic-create" in their request.

## Process

### Phase 1: Discovery

1. **Understand Requirements**: Clarify the full scope before writing any code
2. **Explore Existing Patterns**: Read similar implementations in the codebase
3. **Identify Dependencies**: Map what needs to change and what's affected
4. **Plan the Approach**: Create a clear plan with discrete steps

### Phase 2: Foundation

1. **Types First**: Define TypeScript types/interfaces before implementation
2. **Schema First**: If database changes are needed, define schema first
3. **API Contract**: Define the interface between components/layers

### Phase 3: Implementation

1. **Core Logic**: Implement the main functionality
2. **Integration**: Connect with existing systems
3. **Edge Cases**: Handle error states and boundary conditions
4. **Validation**: Add input validation at system boundaries

### Phase 4: Verification

1. **Type Check**: Ensure TypeScript compiles without errors
2. **Test**: Write and run tests for critical paths
3. **Review**: Self-review for security, performance, and maintainability

## Architecture Principles

### For This Project (Terragon)

**Frontend (Next.js App Router)**:

- Use Server Components by default, Client Components only when needed
- Server Actions for mutations
- React Query for client-side data fetching
- Jotai for local state management
- Radix UI + shadcn/ui for components

**Database**:

- Drizzle ORM for schema and queries
- Define schema in `packages/shared/src/db/`
- Use transactions for multi-step operations

**API Layer**:

- Server Actions in `apps/www/src/server-actions/`
- ORPC for CLI API contracts
- Proper error handling with typed responses

**Real-time**:

- PartyKit for WebSocket communication
- PartySocket on the client side

### General Principles

- **Separation of Concerns**: Keep business logic separate from UI
- **Type Safety**: Use TypeScript strictly, avoid `any`
- **Error Boundaries**: Handle failures gracefully at each layer
- **Composability**: Build small, reusable pieces
- **Convention Over Configuration**: Follow existing project patterns

## File Naming Conventions (Terragon)

| Type            | Convention                  | Example                |
| --------------- | --------------------------- | ---------------------- |
| React Component | kebab-case                  | `thread-list.tsx`      |
| Server Action   | kebab-case                  | `create-thread.ts`     |
| Utility         | kebab-case                  | `format-date.ts`       |
| Hook            | camelCase with `use` prefix | `useThread.ts`         |
| Type file       | kebab-case                  | `thread-types.ts`      |
| Test file       | same name + `.test`         | `thread-list.test.tsx` |
| DB Schema       | kebab-case                  | `threads.ts`           |

## Incremental Delivery

Each step should leave the codebase in a working state. Never:

- Leave broken imports
- Leave unused variables or dead code
- Skip type annotations on public interfaces
- Commit incomplete error handling at system boundaries

## Context Compaction

When summarizing context, ALWAYS include:

```
TRYB PRACY: anthropic-create - kontynuuj strukturalne tworzenie funkcjonalności
```
