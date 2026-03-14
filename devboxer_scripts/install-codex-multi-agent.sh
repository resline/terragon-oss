#!/bin/bash
# install-codex-multi-agent.sh
# Enables Codex CLI multi-agent mode in ~/.codex/config.toml
# Assumes Codex CLI is preinstalled in the environment

set -e

echo "=== Codex CLI Multi-Agent Installer ==="
echo

# ──────────────────────────────────────────
# 1. Verify Codex CLI availability
# ──────────────────────────────────────────
echo "[1/3] Checking Codex CLI availability..."

if command -v codex &> /dev/null; then
    CURRENT_VERSION=$(codex --version 2>/dev/null || echo "unknown")
    echo "      Codex CLI detected: $CURRENT_VERSION"
else
    echo "      ERROR: codex command not found (environment should provide preinstalled Codex CLI)"
    exit 1
fi

echo

# ──────────────────────────────────────────
# 2. Enable multi-agent in Codex config
# ──────────────────────────────────────────
echo "[2/3] Enabling multi-agent mode..."

CODEX_DIR="${HOME}/.codex"
CODEX_CONFIG="${CODEX_DIR}/config.toml"

mkdir -p "$CODEX_DIR"

if [ ! -f "$CODEX_CONFIG" ]; then
    cat > "$CODEX_CONFIG" << 'EOF'
[features]
multi_agent = true
EOF
    echo "      Created ${CODEX_CONFIG} with multi-agent enabled"
else
    TMP_CONFIG=$(mktemp)

    if grep -q "^\[features\][[:space:]]*$" "$CODEX_CONFIG"; then
        awk '
            BEGIN { in_features = 0; inserted = 0 }
            /^\[features\][[:space:]]*$/ { print; in_features = 1; next }
            in_features && /^\[/ {
                if (!inserted) {
                    print "multi_agent = true"
                    inserted = 1
                }
                in_features = 0
            }
            in_features && /^[[:space:]]*multi_agent[[:space:]]*=/ {
                if (!inserted) {
                    print "multi_agent = true"
                    inserted = 1
                }
                next
            }
            { print }
            END {
                if (in_features && !inserted) {
                    print "multi_agent = true"
                }
            }
        ' "$CODEX_CONFIG" > "$TMP_CONFIG"
    else
        cat "$CODEX_CONFIG" > "$TMP_CONFIG"
        cat >> "$TMP_CONFIG" << 'EOF'

[features]
multi_agent = true
EOF
    fi

    mv "$TMP_CONFIG" "$CODEX_CONFIG"
    echo "      Updated ${CODEX_CONFIG}: multi-agent enabled"
fi

echo

# ──────────────────────────────────────────
# 3. Verify
# ──────────────────────────────────────────
echo "[3/3] Verifying setup..."
CODEX_VERSION=$(codex --version 2>/dev/null || echo "error")
echo "      Codex version: $CODEX_VERSION"
if grep -A 5 "^\[features\][[:space:]]*$" "$CODEX_CONFIG" | grep -q "^[[:space:]]*multi_agent[[:space:]]*=[[:space:]]*true"; then
    echo "      Multi-agent: enabled"
else
    echo "      Multi-agent: verification failed"
    exit 1
fi

echo
echo "=== Codex CLI ready ==="
