#!/usr/bin/env bash
# vault-index: Generate a lightweight index of vault documents
# Extracts tags and description from frontmatter for quick Claude reference
# Runs from plugin context - uses CWD as vault root

set -euo pipefail

VAULT_DIR="${PWD}"

# Verify this looks like an Obsidian vault
if [[ ! -d "${VAULT_DIR}/.obsidian" ]]; then
    echo "Not an Obsidian vault (no .obsidian directory)"
    exit 0
fi

# Header
echo "Available vault documentation (use vault-search or vault-search-tags for lookup):"
echo ""
echo "File | Tags | Description"
echo "---- | ---- | -----------"

# Find all .md files, excluding system files
fd -e md --exclude '.obsidian' --exclude '.scripts' --exclude 'CLAUDE.md' . "$VAULT_DIR" | sort | while read -r file; do
    # Get relative path from vault root
    relpath="${file#$VAULT_DIR/}"
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
