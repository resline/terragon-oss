#!/bin/bash
# install-codex-latest.sh
# Installs or updates Codex CLI to the latest npm version and prepares
# the local agents directory for custom subagents.

set -euo pipefail

echo "=== Codex CLI Latest Installer ==="
echo

NPM_PREFIX=$(npm config get prefix)
CODEX_NPM_BIN="${NPM_PREFIX}/bin/codex"
CODEX_CLI="${NPM_PREFIX}/lib/node_modules/@openai/codex/bin/codex.js"
CODEX_DIR="${HOME}/.codex"
CODEX_AGENTS_DIR="${CODEX_DIR}/agents"

echo "[1/3] Checking Codex CLI installation..."

CURRENT_VERSION=""
if [ -f "$CODEX_CLI" ]; then
    CURRENT_VERSION=$(node "$CODEX_CLI" --version 2>/dev/null | awk '{print $NF}' || echo "")
elif command -v codex >/dev/null 2>&1; then
    CURRENT_VERSION=$(codex --version 2>/dev/null | awk '{print $NF}' || echo "")
fi

LATEST_VERSION=$(npm view @openai/codex version 2>/dev/null || echo "")

if [ -z "$LATEST_VERSION" ]; then
    echo "      ERROR: failed to fetch the latest Codex version from npm"
    exit 1
fi

if [ -n "$CURRENT_VERSION" ] && [ "$CURRENT_VERSION" = "$LATEST_VERSION" ]; then
    echo "      Codex CLI already at latest version: $CURRENT_VERSION"
else
    if [ -n "$CURRENT_VERSION" ]; then
        echo "      Updating Codex CLI: $CURRENT_VERSION -> $LATEST_VERSION"
    else
        echo "      Installing Codex CLI (latest: $LATEST_VERSION)..."
    fi
    npm install -g @openai/codex@latest
fi

INSTALLED_VERSION=$(codex --version 2>/dev/null | awk '{print $NF}' || echo "")
echo "      Installed version: ${INSTALLED_VERSION:-unknown}"
echo

echo "[2/3] Preparing Codex agent directories..."
mkdir -p "${HOME}/.codex/agents"
echo "      Agents directory ready: ${CODEX_AGENTS_DIR}"
echo "      Subagents are supported by current Codex releases without forcing legacy feature flags"
echo

echo "[3/3] Verifying installation..."
ACTIVE_CODEX=$(command -v codex 2>/dev/null || echo "")
ACTIVE_VERSION=$(codex --version 2>/dev/null || echo "error")
echo "      Codex version: $ACTIVE_VERSION"
echo "      npm binary: $CODEX_NPM_BIN"
echo "      active command: $ACTIVE_CODEX"

if [ ! -f "$CODEX_CLI" ]; then
    echo "      ERROR: Codex CLI not found at $CODEX_CLI"
    exit 1
fi

if [ -z "$ACTIVE_CODEX" ]; then
    echo "      ERROR: codex command is not available after installation"
    exit 1
fi

echo
echo "=== Codex CLI ready ==="
