#!/usr/bin/env bash
# init.sh: Validate vault and show document index
# Called by Claude before any vault search operation

set -euo pipefail

# Determine vault directory
vault_dir="${CLAUDE_OBSIDIAN_VAULT_DIRECTORY:-$PWD}"
# Expand tilde if present
vault_dir="${vault_dir/#\~/$HOME}"

# Check if it's a valid Obsidian vault
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

echo "Vault: $vault_dir"
echo ""
echo "Available documents:"
echo ""
echo "File | Tags | Description"
echo "---- | ---- | -----------"

# Find all .md files, excluding system files
fd -e md --exclude '.obsidian' --exclude '.scripts' --exclude 'CLAUDE.md' . "$vault_dir" | sort | while read -r file; do
    # Get relative path from vault root
    relpath="${file#$vault_dir/}"
    filename="${relpath%.md}"

    # Extract frontmatter (between first --- and second ---)
    frontmatter=$(awk '/^---$/{p++; next} p==1{print} p==2{exit}' "$file")

    # Extract tags (handles multi-line YAML arrays)
    tags=$(echo "$frontmatter" | awk '
        /^tags:/ { intags=1; next }
        intags && /^  - / {
            sub(/^  - /, "")
            tags = tags ? tags "," $0 : $0
            next
        }
        intags && /^[a-z]/ { intags=0 }
        END { print tags }
    ')

    # Extract description (single line value)
    desc=$(echo "$frontmatter" | awk -F': ' '/^description:/ {$1=""; print substr($0,2)}')

    # Output format: filename | tags | description
    printf "%s | %s | %s\n" "$filename" "${tags:--}" "${desc:--}"
done

echo ""
echo "Use vault-search.sh <pattern> for content search"
echo "Use vault-search-tags.sh <tag> for tag search"
