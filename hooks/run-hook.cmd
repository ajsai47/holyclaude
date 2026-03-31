#!/usr/bin/env bash
# run-hook.cmd -- Dispatches hook events to registered handlers
# Called by hooks.json for lifecycle events that don't go through the memory worker
set -euo pipefail

HOOK_NAME="${1:-unknown}"
PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT:-$HOME/.claude/plugins/holyclaude}"

case "$HOOK_NAME" in
  session-start)
    # gstack session tracking
    mkdir -p ~/.gstack/sessions 2>/dev/null || true
    touch ~/.gstack/sessions/"$$" 2>/dev/null || true
    # Clean stale sessions (>2 hours old)
    find ~/.gstack/sessions -mmin +120 -type f -exec rm {} + 2>/dev/null || true
    ;;
  *)
    # Unknown hook, silently ignore
    ;;
esac
