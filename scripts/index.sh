#!/usr/bin/env bash
# index.sh: Output document index for an Obsidian vault
# Used by detect-vault hook and available for manual refresh

set -euo pipefail

vault_dir="${CLAUDE_OBSIDIAN_VAULT_DIRECTORY:-$PWD}"
vault_dir="${vault_dir/#\~/$HOME}"

if [[ ! -d "$vault_dir/.obsidian" ]]; then
    echo "ERROR: No valid Obsidian vault at $vault_dir"
    exit 1
fi

echo "Vault: $vault_dir"
echo ""
echo "Available documents:"
echo ""
echo "File | Tags | Description"
echo "---- | ---- | -----------"

fd -e md --exclude '.obsidian' --exclude '.scripts' --exclude 'CLAUDE.md' . "$vault_dir" | sort | while read -r file; do
    relpath="${file#$vault_dir/}"
    filename="${relpath%.md}"

    frontmatter=$(awk '/^---$/{p++; next} p==1{print} p==2{exit}' "$file")

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

    desc=$(echo "$frontmatter" | awk -F': ' '/^description:/ {$1=""; print substr($0,2)}')

    printf "%s | %s | %s\n" "$filename" "${tags:--}" "${desc:--}"
done
