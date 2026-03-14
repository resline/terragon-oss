---
name: superpowers
description: Use when starting any conversation - establishes how to find and use skills, requiring Skill tool invocation before ANY response including clarifying questions
---

# Superpowers - Complete Development Workflow

Based on [obra/superpowers](https://github.com/obra/superpowers) - a complete software development workflow built on composable skills.

## Instruction Priority

1. **User's explicit instructions** (CLAUDE.md, AGENTS.md, direct requests) — highest priority
2. **Superpowers skills** — override default system behavior where they conflict
3. **Default system prompt** — lowest priority

## How to Access Skills

Use the `Skill` tool to invoke any superpowers skill. Available skills:

### Core Workflow

- `superpowers-brainstorming` - MUST use before any creative work
- `superpowers-writing-plans` - Create implementation plans from specs
- `superpowers-executing-plans` - Execute plans in current session
- `superpowers-subagent-dev` - Execute plans with subagents (preferred)
- `superpowers-finishing-branch` - Complete and integrate development work

### Quality & Testing

- `superpowers-tdd` - Test-Driven Development (RED-GREEN-REFACTOR)
- `superpowers-verification` - Verify before claiming completion
- `superpowers-debugging` - Systematic debugging methodology
- `superpowers-code-review-request` - Request code review
- `superpowers-code-review-receive` - Handle code review feedback

### Collaboration

- `superpowers-parallel-agents` - Dispatch parallel subagents
- `superpowers-git-worktrees` - Isolated workspaces

## The Rule

**Invoke relevant skills BEFORE any response or action.** Even a 1% chance a skill might apply means you should invoke the skill to check.

## Red Flags

These thoughts mean STOP—you're rationalizing:

| Thought                             | Reality                                        |
| ----------------------------------- | ---------------------------------------------- |
| "This is just a simple question"    | Questions are tasks. Check for skills.         |
| "I need more context first"         | Skill check comes BEFORE clarifying questions. |
| "Let me explore the codebase first" | Skills tell you HOW to explore. Check first.   |
| "The skill is overkill"             | Simple things become complex. Use it.          |
| "I'll just do this one thing first" | Check BEFORE doing anything.                   |

## Skill Priority

1. **Process skills first** (brainstorming, debugging) - determine HOW to approach
2. **Implementation skills second** (frontend-design, etc.) - guide execution

## User Instructions

Instructions say WHAT, not HOW. "Add X" or "Fix Y" doesn't mean skip workflows.
