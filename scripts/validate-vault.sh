#!/usr/bin/env bash
# PreToolUse hook: Validate vault directory before vault-search skill
# Blocks skill invocation if no valid vault is configured

set -euo pipefail

# Determine vault directory
vault_dir="${CLAUDE_OBSIDIAN_VAULT_DIRECTORY:-$PWD}"

# Check if it's a valid Obsidian vault (has .obsidian directory)
if [[ -d "$vault_dir/.obsidian" ]]; then
    echo '{"continue":true,"suppressOutput":true}'
    exit 0
fi

# Not a valid vault - block and provide guidance
cat <<EOF
{
    "continue": false,
    "suppressOutput": false,
    "message": "No valid Obsidian vault found. The directory '$vault_dir' does not contain a .obsidian folder. Either set CLAUDE_OBSIDIAN_VAULT_DIRECTORY to point to your vault, or run from within your vault directory."
}
EOF
