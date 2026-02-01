---
name: vault-search
description: Research tool for user's personal knowledge base. Use when user says "search notes", "find notes", "check my notes", "what do I know about", or when discussing topics the user may have documented. Consider proactively when the user needs context that could exist in their notes.
---

# Obsidian Vault Search

Search an Obsidian vault by content or by tag. Choose the appropriate tool based on what the user needs.

## Initialization

Run the init script to validate configuration and see usage:

```bash
!`${CLAUDE_PLUGIN_ROOT}/scripts/init.sh`
```

**Note**: When starting inside an Obsidian vault, the document index is automatically loaded via session hook. Use `index.sh` to refresh the index if needed.

## What This Skill Provides

1. **Content Search** - Find documents containing specific words or phrases
2. **Tag Search** - Find documents by frontmatter tag classification
3. **Metadata Context** - See document name, tags, and description with results

## When to Use Which Tool

| User Intent | Tool | Example |
|-------------|------|---------|
| Search for words/phrases in content | `vault-search` | "search notes for nvidia" |
| Find documents by category/tag | `vault-search-tags` | "find notes tagged hardware" |

## Content Search: `vault-search`

Search document content using ripgrep. Returns matching lines with context.

```bash
${CLAUDE_PLUGIN_ROOT}/vault-search.sh <pattern>
```

**Output**: Results grouped by file showing Name, Tags, Description, then matching lines.

**Example**:
```bash
${CLAUDE_PLUGIN_ROOT}/vault-search.sh nvidia
```

## Tag Search: `vault-search-tags`

Find documents by frontmatter tag. Returns a table of matching documents.

```bash
${CLAUDE_PLUGIN_ROOT}/vault-search-tags.sh <tag>
```

**Output**: Markdown table with File, Tags, Description columns.

**Example**:
```bash
${CLAUDE_PLUGIN_ROOT}/vault-search-tags.sh hardware
```

## Script References

- [vault-search](references/vault-search) - Content search implementation
- [vault-search-tags](references/vault-search-tags) - Tag search implementation

---

**Key Principle**: Use content search for finding specific information; use tag search for browsing by category.
