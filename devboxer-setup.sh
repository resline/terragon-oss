#!/bin/bash
# devboxer-setup.sh
# Main setup script for DevBoxer environment
# Optimized: runs project deps, Claude Code, and Codex CLI setup in parallel

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "========================================"
echo "       DevBoxer Environment Setup       "
echo "========================================"
echo

# ──────────────────────────────────────────
# Ensure IS_SANDBOX=1 is set globally.
# Claude Code refuses --dangerously-skip-permissions under root unless
# IS_SANDBOX=1 is in the environment. DevBoxer is a sandbox by definition,
# so we set it system-wide for every process that runs in this container.
# ──────────────────────────────────────────
echo "[pre] Ensuring IS_SANDBOX=1 is set system-wide..."

# 1. /etc/environment — inherited by PAM sessions and systemd units
if [ -w /etc/environment ] || [ "$(id -u)" = "0" ]; then
    if ! grep -q '^IS_SANDBOX=' /etc/environment 2>/dev/null; then
        echo 'IS_SANDBOX=1' >> /etc/environment
        echo "      Added IS_SANDBOX=1 to /etc/environment"
    else
        echo "      /etc/environment already has IS_SANDBOX entry"
    fi
fi

# 2. /etc/profile.d — sourced by every interactive login shell
PROFILE_SNIPPET=/etc/profile.d/devboxer-sandbox.sh
if [ -d /etc/profile.d ] && { [ -w /etc/profile.d ] || [ "$(id -u)" = "0" ]; }; then
    if [ ! -f "$PROFILE_SNIPPET" ]; then
        cat > "$PROFILE_SNIPPET" << 'PROFILE_EOF'
# devboxer: mark this container as a sandbox so Claude Code and other tools
# allow --dangerously-skip-permissions under root.
export IS_SANDBOX=1
PROFILE_EOF
        chmod 0644 "$PROFILE_SNIPPET"
        echo "      Wrote $PROFILE_SNIPPET"
    else
        echo "      $PROFILE_SNIPPET already present"
    fi
fi

# 3. Current shell — so anything that runs below inherits it immediately
export IS_SANDBOX=1
echo "      IS_SANDBOX exported in current shell"
echo

# Run setup scripts in parallel
bash "${SCRIPT_DIR}/devboxer_scripts/install-project-deps.sh" &
DEPS_PID=$!

bash "${SCRIPT_DIR}/devboxer_scripts/install-claude-sandbox.sh" &
CLAUDE_PID=$!

bash "${SCRIPT_DIR}/devboxer_scripts/install-codex-latest.sh" &
CODEX_PID=$!

# Wait for all to complete with explicit error handling
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
    echo "WARNING: Codex CLI setup had issues (exit code: $CODEX_EXIT)"
fi

echo "========================================"
echo "       DevBoxer Setup Complete!         "
echo "========================================"
