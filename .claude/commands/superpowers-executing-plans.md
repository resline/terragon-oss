---
name: superpowers-executing-plans
description: Use when you have a written implementation plan to execute in a separate session with review checkpoints
---

# Executing Plans

## Overview

Load plan, review critically, execute all tasks, report when complete.

**Note:** If subagents are available, use superpowers-subagent-dev instead - it produces higher quality work.

## The Process

### Step 1: Load and Review Plan

1. Read plan file
2. Review critically - identify questions or concerns
3. If concerns: Raise them before starting
4. If no concerns: Create TodoWrite and proceed

### Step 2: Execute Tasks

For each task:

1. Mark as in_progress
2. Follow each step exactly
3. Run verifications as specified
4. Mark as completed

### Step 3: Complete Development

After all tasks complete and verified:

- Use superpowers-finishing-branch skill

## When to Stop and Ask for Help

- Hit a blocker (missing dependency, test fails, instruction unclear)
- Plan has critical gaps
- You don't understand an instruction
- Verification fails repeatedly

**Ask for clarification rather than guessing.**
