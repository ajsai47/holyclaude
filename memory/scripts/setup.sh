#!/usr/bin/env bash
# Memory system setup — creates data directory and verifies worker can start
set -euo pipefail

DATA_DIR="${CLAUDE_MEM_DATA_DIR:-$HOME/.claude-mem}"
mkdir -p "$DATA_DIR"
mkdir -p "$DATA_DIR/logs"
mkdir -p "$DATA_DIR/archives"
mkdir -p "$DATA_DIR/backups"

echo "  Memory data directory: $DATA_DIR"

# Try to start the worker to verify it works
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Find bun
BUN_CMD=""
if command -v bun &>/dev/null; then
  BUN_CMD="bun"
elif [ -f "$HOME/.bun/bin/bun" ]; then
  BUN_CMD="$HOME/.bun/bin/bun"
fi

if [ -n "$BUN_CMD" ] && [ -f "$SCRIPT_DIR/worker-cli.js" ]; then
  echo "  Starting memory worker..."
  "$BUN_CMD" "$SCRIPT_DIR/worker-cli.js" start 2>/dev/null || echo "  (Worker start deferred — will start on next session)"
else
  echo "  (Worker start deferred — bun not found, will install on first session)"
fi

echo "  Memory system ready."
