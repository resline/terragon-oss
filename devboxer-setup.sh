#!/bin/bash
# devboxer-setup.sh
# Main setup script for DevBoxer environment
# Optimized: runs project deps and Claude Code setup in parallel

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "========================================"
echo "       DevBoxer Environment Setup       "
echo "========================================"
echo

# Run both setup scripts in parallel
"${SCRIPT_DIR}/devboxer_scripts/install-project-deps.sh" &
DEPS_PID=$!

"${SCRIPT_DIR}/devboxer_scripts/install-claude-sandbox.sh" &
CLAUDE_PID=$!

"${SCRIPT_DIR}/devboxer_scripts/install-codex-multi-agent.sh" &
CODEX_PID=$!

# Wait for both to complete with explicit error handling
DEPS_EXIT=0
CLAUDE_EXIT=0
CODEX_EXIT=0
wait $DEPS_PID || DEPS_EXIT=$?
wait $CLAUDE_PID || CLAUDE_EXIT=$?
wait $CODEX_PID || CODEX_EXIT=$?

echo

if [ $DEPS_EXIT -ne 0 ]; then
    echo "WARNING: Project dependencies setup had issues (exit code: $DEPS_EXIT)"
fi
if [ $CLAUDE_EXIT -ne 0 ]; then
    echo "WARNING: Claude Code setup had issues (exit code: $CLAUDE_EXIT)"
fi
if [ $CODEX_EXIT -ne 0 ]; then
    echo "WARNING: Codex CLI multi-agent setup had issues (exit code: $CODEX_EXIT)"
fi

echo "========================================"
echo "       DevBoxer Setup Complete!         "
echo "========================================"
