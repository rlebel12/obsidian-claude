#!/usr/bin/env bash
# vault-search: Search document content
# Usage: vault-search <pattern>
# Groups results by file with metadata headers

set -euo pipefail

if [[ $# -lt 1 ]]; then
    echo "Usage: vault-search <pattern>" >&2
    exit 1
fi

PATTERN="$1"
VAULT_DIR="${CLAUDE_OBSIDIAN_VAULT_DIRECTORY:-$PWD}"
# Expand tilde if present
VAULT_DIR="${VAULT_DIR/#\~/$HOME}"

# Get list of matching files
files=$(rg --type md \
   --glob '!.obsidian/**' \
   --glob '!.scripts/**' \
   --glob '!CLAUDE.md' \
   -i -l \
   "$PATTERN" \
   "$VAULT_DIR" 2>/dev/null | sort)

if [[ -z "$files" ]]; then
    echo "No matches found"
    exit 0
fi

first=true
while read -r file; do
    # Add separator between files
    if [[ "$first" == true ]]; then
        first=false
    else
        echo "---------------"
    fi

    relpath="${file#$VAULT_DIR/}"
    filename="${relpath%.md}"

    # Extract frontmatter
    frontmatter=$(awk '/^---$/{p++; next} p==1{print} p==2{exit}' "$file")

    # Extract tags
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

    # Print file header
    echo "Name: $filename"
    echo "Tags: ${tags:--}"
    echo "Description: ${desc:--}"
    echo ""

    # Show matches with context
    rg -i -n -C 1 --no-filename "$PATTERN" "$file" 2>/dev/null
done < <(echo "$files")
