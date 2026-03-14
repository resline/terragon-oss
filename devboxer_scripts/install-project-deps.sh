#!/bin/bash
# install-project-deps.sh
# Installs project-specific dependencies for Terragon monorepo
# Tailored for pnpm workspace with Next.js, Drizzle, PartyKit stack

set -e

echo "=== Terragon Project Dependencies Installer ==="
echo

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# ──────────────────────────────────────────
# 1. Verify required tools
# ──────────────────────────────────────────
echo "[1/5] Verifying required tools..."

MISSING_TOOLS=()

if ! command -v node &> /dev/null; then
    MISSING_TOOLS+=("node")
fi

if ! command -v pnpm &> /dev/null; then
    echo "      pnpm not found, installing via corepack..."
    if command -v corepack &> /dev/null; then
        corepack enable
        corepack prepare pnpm@10.14.0 --activate
    else
        npm install -g pnpm@10.14.0
    fi
fi

if ! command -v git &> /dev/null; then
    MISSING_TOOLS+=("git")
fi

if [ ${#MISSING_TOOLS[@]} -gt 0 ]; then
    echo "      ERROR: Missing required tools: ${MISSING_TOOLS[*]}"
    echo "      Please install them before running this script."
    exit 1
fi

NODE_VERSION=$(node --version 2>/dev/null || echo "unknown")
PNPM_VERSION=$(pnpm --version 2>/dev/null || echo "unknown")
echo "      Node.js: $NODE_VERSION"
echo "      pnpm: $PNPM_VERSION"

echo

# ──────────────────────────────────────────
# 2. Install workspace dependencies
# ──────────────────────────────────────────
echo "[2/5] Installing workspace dependencies..."

cd "$PROJECT_ROOT"

# Use frozen lockfile if available, otherwise regular install
if [ -f "pnpm-lock.yaml" ]; then
    pnpm install --frozen-lockfile 2>/dev/null || pnpm install
else
    pnpm install
fi

echo "      Workspace dependencies installed"
echo

# ──────────────────────────────────────────
# 3. Verify critical packages
# ──────────────────────────────────────────
echo "[3/5] Verifying critical packages..."

CRITICAL_PACKAGES=(
    "next"
    "react"
    "typescript"
    "drizzle-orm"
    "vitest"
    "turbo"
)

ALL_FOUND=true
for pkg in "${CRITICAL_PACKAGES[@]}"; do
    if pnpm list "$pkg" --depth=0 --recursive 2>/dev/null | grep -q "$pkg"; then
        echo "      ✓ $pkg"
    else
        echo "      ✗ $pkg (not found - may be in a sub-workspace)"
        ALL_FOUND=false
    fi
done

echo

# ──────────────────────────────────────────
# 4. Setup environment files
# ──────────────────────────────────────────
echo "[4/5] Checking environment files..."

# Copy .env.example files if .env.development.local doesn't exist
ENV_DIRS=(
    "apps/www"
    "apps/broadcast"
    "packages/shared"
    "packages/env"
)

for dir in "${ENV_DIRS[@]}"; do
    ENV_EXAMPLE="$PROJECT_ROOT/$dir/.env.example"
    ENV_LOCAL="$PROJECT_ROOT/$dir/.env.development.local"

    if [ -f "$ENV_EXAMPLE" ] && [ ! -f "$ENV_LOCAL" ]; then
        cp "$ENV_EXAMPLE" "$ENV_LOCAL"
        echo "      Created $dir/.env.development.local from .env.example"
    elif [ -f "$ENV_LOCAL" ]; then
        echo "      $dir/.env.development.local already exists"
    fi
done

echo

# ──────────────────────────────────────────
# 5. Build shared packages
# ──────────────────────────────────────────
echo "[5/5] Building shared packages..."

# Build the shared package first as others depend on it
if [ -f "$PROJECT_ROOT/packages/shared/package.json" ]; then
    pnpm -C "$PROJECT_ROOT/packages/shared" build 2>/dev/null && \
        echo "      Built @terragon/shared" || \
        echo "      Skipped @terragon/shared build (may need env vars)"
fi

# Build env package
if [ -f "$PROJECT_ROOT/packages/env/package.json" ]; then
    pnpm -C "$PROJECT_ROOT/packages/env" build 2>/dev/null && \
        echo "      Built @terragon/env" || \
        echo "      Skipped @terragon/env build (may need env vars)"
fi

echo
echo "=== Terragon project dependencies ready ==="
echo
echo "Next steps:"
echo "  1. Configure .env.development.local files with your API keys"
echo "  2. Start Docker: docker compose up -d"
echo "  3. Push DB schema: pnpm -C packages/shared drizzle-kit-push-dev"
echo "  4. Run dev server: pnpm dev"
