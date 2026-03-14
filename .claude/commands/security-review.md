---
name: security-review
description: "Use when the user writes 'security-review' - activates security-focused code review mode. Checks for OWASP Top 10 vulnerabilities, authentication/authorization issues, data exposure, and injection attacks specific to the project's stack."
---

# Security Review Mode

## Overview

Focused security analysis of code changes and existing implementations. Checks for common vulnerabilities specific to the Terragon stack: Next.js, React, PostgreSQL, GitHub OAuth, and sandbox orchestration.

## When to Use

**TRIGGER:** User explicitly writes "security-review" in their request.

## Checklist

### 1. Injection Attacks

- [ ] SQL injection via raw queries (check Drizzle usage)
- [ ] Command injection in sandbox operations
- [ ] XSS via dangerouslySetInnerHTML or unescaped user content
- [ ] Template injection in email templates
- [ ] Path traversal in file operations

### 2. Authentication & Authorization

- [ ] Missing auth checks on Server Actions
- [ ] Broken access control (user A accessing user B's data)
- [ ] Token exposure in client-side code
- [ ] Missing rate limiting on auth endpoints
- [ ] Session fixation vulnerabilities

### 3. Data Exposure

- [ ] Sensitive data in API responses (API keys, tokens)
- [ ] Environment variables exposed to client
- [ ] Verbose error messages leaking internals
- [ ] Missing field-level access control
- [ ] Logs containing sensitive data

### 4. Sandbox Security

- [ ] Sandbox escape vectors
- [ ] Resource limits on sandbox operations
- [ ] Network isolation between sandboxes
- [ ] Credential isolation between users
- [ ] File system access boundaries

### 5. API Security

- [ ] Missing CSRF protection
- [ ] Missing rate limiting on public endpoints
- [ ] Insecure direct object references (IDOR)
- [ ] Missing input validation at system boundaries
- [ ] Overly permissive CORS configuration

### 6. Dependencies

- [ ] Known vulnerabilities in dependencies (`pnpm audit`)
- [ ] Outdated packages with security patches
- [ ] Unnecessary dependencies increasing attack surface

## Severity Levels

| Level        | Definition                              | Example                         |
| ------------ | --------------------------------------- | ------------------------------- |
| **Critical** | Active exploit possible                 | SQL injection, auth bypass      |
| **High**     | Data exposure or privilege escalation   | IDOR, missing auth check        |
| **Medium**   | Requires specific conditions to exploit | Stored XSS, CSRF                |
| **Low**      | Informational or defense-in-depth       | Missing headers, verbose errors |

## Context Compaction

When summarizing context, ALWAYS include:

```
TRYB PRACY: security-review - kontynuuj przegląd bezpieczeństwa kodu
```
