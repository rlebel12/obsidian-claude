#!/usr/bin/env bash
# init.sh: Validate vault configuration and show usage
# Called when skill is explicitly invoked (index auto-loads via hook)

set -euo pipefail

vault_dir="${CLAUDE_OBSIDIAN_VAULT_DIRECTORY:-$PWD}"
vault_dir="${vault_dir/#\~/$HOME}"

if [[ ! -d "$vault_dir/.obsidian" ]]; then
    cat <<EOF
ERROR: No valid Obsidian vault found.

The directory '$vault_dir' does not contain a .obsidian folder.

To use vault search:
  1. Set CLAUDE_OBSIDIAN_VAULT_DIRECTORY to your vault path, OR
  2. Run Claude Code from within your Obsidian vault directory

Example:
  export CLAUDE_OBSIDIAN_VAULT_DIRECTORY=~/Documents/MyVault
EOF
    exit 1
fi

echo "Vault configured: $vault_dir"
echo ""
echo "Search commands:"
echo "  vault-search.sh <pattern>  - Search document content"
echo "  vault-search-tags.sh <tag> - Search by frontmatter tag"
echo ""
echo "To refresh document index: index.sh"
