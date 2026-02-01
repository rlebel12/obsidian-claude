---
name: vault-search
description: Search notes in Obsidian vault. Use when user says "search notes", "search vault", "find notes", "look in my notes", or asks about documents in their vault.
---

# Obsidian Vault Search

Search an Obsidian vault by content or by tag. Choose the appropriate tool based on what the user needs.

## Required First Step

Before performing any search, ALWAYS run the initialization script:

```bash
${CLAUDE_PLUGIN_ROOT}/scripts/init.sh
```

This validates the vault configuration and shows available documents. If it fails, follow the setup instructions in the error message.

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
