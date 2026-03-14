#!/bin/bash
# install-claude-sandbox.sh
# Installs/updates Claude Code to the latest version and sets up wrapper that automatically
# enables IS_SANDBOX=1 when --dangerously-skip-permissions is used
# Wrapper is installed in /usr/local/bin so npm updates do not overwrite it

set -e

echo "=== Claude Code Sandbox Installer ==="
echo

# Detect npm global prefix
NPM_PREFIX=$(npm config get prefix)
CLAUDE_NPM_BIN="${NPM_PREFIX}/bin/claude"
CLAUDE_CLI="${NPM_PREFIX}/lib/node_modules/@anthropic-ai/claude-code/cli.js"
WRAPPER_BIN="/usr/local/bin/claude"

# ──────────────────────────────────────────
# 1. Install/update Claude Code to latest version
# ──────────────────────────────────────────
echo "[1/3] Checking Claude Code installation..."

CURRENT_VERSION=""
if [ -f "$CLAUDE_CLI" ]; then
    CURRENT_VERSION=$(node "$CLAUDE_CLI" --version 2>/dev/null | head -1 | grep -oP '[\d.]+' || echo "")
elif command -v claude &> /dev/null; then
    CURRENT_VERSION=$(claude --version 2>/dev/null | head -1 | grep -oP '[\d.]+' || echo "")
fi

# Pobierz najnowszą dostępną wersję z npm registry
LATEST_VERSION=$(npm view @anthropic-ai/claude-code version 2>/dev/null || echo "")

if [ -n "$CURRENT_VERSION" ] && [ "$CURRENT_VERSION" = "$LATEST_VERSION" ]; then
    echo "      Claude Code already at latest version: $CURRENT_VERSION"
else
    if [ -n "$CURRENT_VERSION" ]; then
        echo "      Updating Claude Code: $CURRENT_VERSION -> $LATEST_VERSION"
    else
        echo "      Installing Claude Code (latest: $LATEST_VERSION)..."
    fi
    npm install -g @anthropic-ai/claude-code@latest
    INSTALLED_VERSION=$(node "$CLAUDE_CLI" --version 2>/dev/null | head -1 || echo "unknown")
    echo "      Installed version: $INSTALLED_VERSION"
fi

echo

# ──────────────────────────────────────────
# 2. Create sandbox wrapper (skip if already configured)
# ──────────────────────────────────────────
echo "[2/3] Checking sandbox wrapper..."

if [ ! -f "$CLAUDE_CLI" ]; then
    echo "      ERROR: Claude CLI not found at $CLAUDE_CLI"
    exit 1
fi

if [ -f "$WRAPPER_BIN" ] && grep -q "DEVBOXER_CLAUDE_WRAPPER" "$WRAPPER_BIN" 2>/dev/null; then
    echo "      Sandbox wrapper already configured"
else
    echo "      Creating sandbox wrapper..."

    # Create wrapper script
    cat > "$WRAPPER_BIN" << EOF
#!/bin/bash
# DEVBOXER_CLAUDE_WRAPPER
# Claude Code wrapper - automatically sets IS_SANDBOX=1 when --dangerously-skip-permissions is used

CLAUDE_REAL="${CLAUDE_CLI}"

# Check if --dangerously-skip-permissions is among arguments
for arg in "\$@"; do
    if [[ "\$arg" == "--dangerously-skip-permissions" ]]; then
        export IS_SANDBOX=1
        break
    fi
done

exec node "\$CLAUDE_REAL" "\$@"
EOF

    chmod +x "$WRAPPER_BIN"
    echo "      Wrapper created at: $WRAPPER_BIN"
fi

echo

# ──────────────────────────────────────────
# 3. Verify
# ──────────────────────────────────────────
echo "[3/3] Verifying installation..."
WRAPPER_PATH=$(command -v claude 2>/dev/null || echo "")
WRAPPER_VERSION=$("$WRAPPER_BIN" --version 2>/dev/null || echo "error")
echo "      Claude version: $WRAPPER_VERSION"
echo "      npm binary: $CLAUDE_NPM_BIN"
echo "      active command: $WRAPPER_PATH"

if [ "$WRAPPER_PATH" != "$WRAPPER_BIN" ]; then
    echo "      ERROR: claude does not resolve to $WRAPPER_BIN"
    exit 1
fi

echo
echo "=== Claude Code ready ==="
