---
name: obsidian
description: Research and author Obsidian vault notes. Use when user says "search notes", "find notes", "check my notes", "what do I know about", or when creating/editing documentation. Consider proactively when the user needs context from their notes.
---

# Obsidian Vault Tools

Tools for searching and authoring Obsidian vault notes.

## Part 1: Search Tools

### What Search Provides

1. **Content Search** - Find documents containing specific words or phrases
2. **Tag Search** - Find documents by frontmatter tag classification
3. **Metadata Context** - See document name, tags, and description with results

### When to Use Which Tool

| User Intent | Tool | Example |
|-------------|------|---------|
| Search for words/phrases in content | `vault-search` | "search notes for nvidia" |
| Find documents by category/tag | `vault-search-tags` | "find notes tagged hardware" |

### Content Search: `vault-search`

Search document content using ripgrep. Returns matching lines with context.

`${CLAUDE_PLUGIN_ROOT}/scripts/vault-search.sh <pattern>`

**Output**: Results grouped by file showing Name, Tags, Description, then matching lines.

### Tag Search: `vault-search-tags`

Find documents by frontmatter tag. Returns a table of matching documents.

`${CLAUDE_PLUGIN_ROOT}/scripts/vault-search-tags.sh <tag>`

**Output**: Markdown table with File, Tags, Description columns.

---

## Part 2: Authoring Notes

Guidelines for creating and editing vault documentation.

### Frontmatter (Required for New Files)

Every new document must include YAML frontmatter:

```yaml
---
date: YYYY-MM-DD
tags:
  - category
  - subcategory
description: Brief one-line summary of the document
aliases:
  - alternate-name
---
```

| Field | Purpose |
|-------|---------|
| `date` | When the configuration was applied, issue resolved, or documentation updated |
| `tags` | Categorize content for tag-based search |
| `description` | Brief summary shown in index output (used for vault discovery) |
| `aliases` | Optional alternate names for the note |

### Callouts for Visual Emphasis

Use callouts to highlight critical information:

```markdown
> [!WARNING]
> Destructive operation - backup first

> [!TIP]
> Useful optimization or shortcut

> [!NOTE]
> Additional context or explanation

> [!IMPORTANT]
> Critical information that must not be missed
```

**When to use each:**
- `[!WARNING]` - Destructive commands, irreversible actions, data loss risks
- `[!TIP]` - Optimizations, shortcuts, or alternative approaches
- `[!NOTE]` - Supplementary context or clarification
- `[!IMPORTANT]` - Critical prerequisites or dependencies

### Wiki Links for Internal References

Link between notes in the vault:

```markdown
[[note-name]]
[[display-management|multi-monitor setup]]
```

- Use wiki links `[[note-name]]` when referencing other vault notes
- Use pipe syntax `[[note|display text]]` for custom link text
- Prefer wiki links over standard markdown links for internal references

### Authoring Best Practices

- Preserve existing frontmatter and wiki links when editing files
- Update the `date` field when updating files for any reason
- Add a `## Related` section at the bottom of docs with wiki links to related notes
- Use descriptive filenames with hyphens (e.g., `nvidia-kernel.md`)
- Never modify the `.obsidian/` directory manually

---

**Key Principles**:
- Use content search for finding specific information; use tag search for browsing by category
- Maintain consistent frontmatter to enable effective vault discovery
