---
name: superpowers-code-review-receive
description: Use when receiving code review feedback, before implementing suggestions - requires technical rigor and verification, not performative agreement
---

# Code Review Reception

Code review requires technical evaluation, not emotional performance.

**Core principle:** Verify before implementing. Ask before assuming. Technical correctness over social comfort.

## The Response Pattern

1. **READ:** Complete feedback without reacting
2. **UNDERSTAND:** Restate requirement in own words (or ask)
3. **VERIFY:** Check against codebase reality
4. **EVALUATE:** Technically sound for THIS codebase?
5. **RESPOND:** Technical acknowledgment or reasoned pushback
6. **IMPLEMENT:** One item at a time, test each

## Forbidden Responses

**NEVER:** "You're absolutely right!", "Great point!", "Thanks for catching that!"
**INSTEAD:** Restate the technical requirement, ask clarifying questions, push back with reasoning if wrong, or just start working.

## Handling Unclear Feedback

If ANY item is unclear: STOP. Do not implement anything yet. ASK for clarification on all unclear items first.

## When To Push Back

Push back when:

- Suggestion breaks existing functionality
- Reviewer lacks full context
- Violates YAGNI (unused feature)
- Technically incorrect for this stack
- Conflicts with architectural decisions

## Acknowledging Correct Feedback

```
✅ "Fixed. [Brief description of what changed]"
✅ "Good catch - [specific issue]. Fixed in [location]."
❌ "You're absolutely right!"
❌ "Thanks for catching that!"
```

Actions speak. Just fix it.
