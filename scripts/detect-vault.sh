#!/usr/bin/env bash
# detect-vault.sh: SessionStart hook to detect Obsidian vault presence
# - If PWD is inside vault: instructs Claude to load the skill
# - If vault configured elsewhere: provides awareness context

set -euo pipefail

vault_dir="${CLAUDE_OBSIDIAN_VAULT_DIRECTORY:-$PWD}"
# Expand tilde if present
vault_dir="${vault_dir/#\~/$HOME}"

# Check if vault exists
if [[ ! -d "$vault_dir/.obsidian" ]]; then
  exit 0
fi

# Check if PWD is inside the vault
pwd_real="$(pwd -P)"
vault_real="$(cd "$vault_dir" && pwd -P)"

if [[ "$pwd_real" == "$vault_real" || "$pwd_real" == "$vault_real"/* ]]; then
  # Inside vault - instruct Claude to load the skill
  cat <<EOF
{
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "Session started inside Obsidian vault at $vault_dir. IMPORTANT: Invoke the vault-search skill now using the Skill tool to load the document index."
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
