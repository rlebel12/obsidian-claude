#!/usr/bin/env bash
# vault-search-tags: Find documents by tag
# Usage: vault-search-tags <tag>

set -euo pipefail

if [[ $# -lt 1 ]]; then
    echo "Usage: vault-search-tags <tag>" >&2
    exit 1
fi

TAG="$1"
VAULT_DIR="${CLAUDE_OBSIDIAN_VAULT_DIRECTORY:-$PWD}"

# Header
echo "File | Tags | Description"
echo "---- | ---- | -----------"

# Search for tag in frontmatter
fd -e md --exclude '.obsidian' --exclude '.scripts' --exclude 'CLAUDE.md' . "$VAULT_DIR" | sort | while read -r file; do
    # Extract frontmatter
    frontmatter=$(awk '/^---$/{p++; next} p==1{print} p==2{exit}' "$file")

    # Check if tag exists in tags field
    if echo "$frontmatter" | grep -qE "(^tags:.*\[.*\b${TAG}\b|^  - ${TAG}$)"; then
        relpath="${file#$VAULT_DIR/}"
        filename="${relpath%.md}"

        # Extract all tags
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

        # Extract description
        desc=$(echo "$frontmatter" | awk -F': ' '/^description:/ {$1=""; print substr($0,2)}')

        printf "%s | %s | %s\n" "$filename" "${tags:--}" "${desc:--}"
    fi
done
