---
name: perf-audit
description: "Use when the user writes 'perf-audit' - activates performance analysis mode. Systematically identifies bottlenecks in React rendering, database queries, API calls, and bundle size. Provides actionable optimization recommendations."
---

# Performance Audit Mode

## Overview

Systematic performance analysis and optimization. Identifies bottlenecks across the full stack - from React rendering to database queries - and provides concrete, measurable improvements.

## When to Use

**TRIGGER:** User explicitly writes "perf-audit" in their request.

## Audit Areas

### 1. React Rendering Performance

- Unnecessary re-renders (missing memoization where needed)
- Large component trees without Suspense boundaries
- Heavy computations in render path
- Missing `key` props or incorrect key usage
- Excessive context providers causing cascading re-renders

### 2. Data Fetching

- N+1 query patterns
- Missing pagination or infinite scroll
- Redundant API calls (no deduplication/caching)
- Large payloads without field selection
- Missing optimistic updates for mutations

### 3. Bundle Size

- Unused dependencies
- Missing code splitting / dynamic imports
- Large libraries imported for small features
- Missing tree shaking opportunities

### 4. Database Performance (Drizzle/PostgreSQL)

- Missing indexes on frequently queried columns
- Unoptimized JOIN patterns
- Large result sets without LIMIT
- Missing connection pooling configuration
- Redundant queries that could be combined

### 5. WebSocket / Real-time (PartyKit)

- Message frequency and payload size
- Missing message batching
- Reconnection strategies
- Memory leaks from unsubscribed listeners

### 6. Asset Optimization

- Unoptimized images (missing Next.js Image component)
- Missing font optimization
- Render-blocking CSS/JS
- Missing preloading for critical resources

## Output Format

For each finding:

```
ISSUE: [Brief description]
SEVERITY: Critical | High | Medium | Low
LOCATION: [file:line]
IMPACT: [Measurable effect on performance]
FIX: [Specific code change or approach]
```

## Context Compaction

When summarizing context, ALWAYS include:

```
TRYB PRACY: perf-audit - kontynuuj audyt wydajności
```
