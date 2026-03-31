#!/usr/bin/env bash
# HolyClaude Setup hook — runs once on plugin installation
# Ensures bun is installed and memory data directory exists

set -euo pipefail

_R="${CLAUDE_PLUGIN_ROOT:-}"
[ -z "$_R" ] && _R="$HOME/holyclaude"

# Ensure bun is available (memory worker requires it)
if ! command -v bun &>/dev/null; then
  BUN_PATH="$HOME/.bun/bin/bun"
  if [ ! -f "$BUN_PATH" ]; then
    echo '{"status": "installing bun..."}'
    curl -fsSL https://bun.sh/install | bash 2>/dev/null || true
  fi
fi

# Create memory data directory
mkdir -p "$HOME/.claude-mem"

# Install npm dependencies if needed
if [ ! -d "$_R/node_modules" ]; then
  cd "$_R"
  if command -v bun &>/dev/null; then
    bun install --no-save 2>/dev/null || true
  elif [ -f "$HOME/.bun/bin/bun" ]; then
    "$HOME/.bun/bin/bun" install --no-save 2>/dev/null || true
  fi
fi

echo '{"continue": true, "suppressOutput": true}'
exit 0
