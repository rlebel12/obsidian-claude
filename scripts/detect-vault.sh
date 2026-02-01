#!/usr/bin/env bash
# detect-vault.sh: SessionStart hook to detect Obsidian vault presence
# - If PWD is inside vault: runs index.sh and includes output as context
# - If vault configured elsewhere: provides awareness context

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

vault_dir="${CLAUDE_OBSIDIAN_VAULT_DIRECTORY:-$PWD}"
vault_dir="${vault_dir/#\~/$HOME}"

# Check if vault exists
if [[ ! -d "$vault_dir/.obsidian" ]]; then
  exit 0
fi

# Check if PWD is inside the vault
pwd_real="$(pwd -P)"
vault_real="$(cd "$vault_dir" && pwd -P)"

if [[ "$pwd_real" == "$vault_real" || "$pwd_real" == "$vault_real"/* ]]; then
  # Inside vault - run index and include output
  index_output=$("$SCRIPT_DIR/index.sh" 2>&1)
  # Escape for JSON
  index_escaped=$(printf '%s' "$index_output" | jq -Rs .)

  cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": ${index_escaped}
  }
}
EOF
else
  # Vault configured but not inside it - provide awareness
  count=$(fd -e md --exclude '.obsidian' --exclude '.scripts' --exclude 'CLAUDE.md' . "$vault_dir" 2>/dev/null | wc -l | tr -d ' ')

  cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "Obsidian vault detected at $vault_dir with $count documents. The vault-search skill is available for searching notes. Consider using it when the user asks about topics they may have documented, when research from personal notes would help, or when they reference 'my notes'."
  }
}
EOF
fi
