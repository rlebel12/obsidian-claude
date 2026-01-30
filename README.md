# obsidian-claude

Claude Code integration for Obsidian vaults. Provides automatic vault indexing at session start and search tools for discovering documentation.

## Installation

```bash
claude plugins add ~/code/obsidian-claude
```

## Features

### SessionStart Hook

When Claude Code starts in an Obsidian vault (directory containing `.obsidian/`), the plugin automatically generates an index of all markdown files with their tags and descriptions. This gives Claude immediate context about available documentation.

### Search Scripts

Two scripts are available for finding vault content:

**vault-search** - Search document content using ripgrep:
```bash
vault-search <pattern> [vault_dir]
```

Returns matching lines grouped by file, with metadata headers showing tags and description.

**vault-search-tags** - Find documents by tag:
```bash
vault-search-tags <tag> [vault_dir]
```

Returns all documents containing the specified tag in their frontmatter.

## Frontmatter Requirements

For best results, documents should include YAML frontmatter:

```yaml
---
date: YYYY-MM-DD
tags:
  - category
  - subcategory
description: Brief one-line summary of the document
---
```

- **date**: When the document was created or last updated
- **tags**: Categorize content for tag-based search
- **description**: Brief summary shown in index output

## CLAUDE.md Integration

Add this section to your vault's CLAUDE.md to document the available scripts:

```markdown
## Vault Discovery Scripts

Scripts from obsidian plugin:
- `vault-search <pattern>` - Search document content
- `vault-search-tags <tag>` - Find documents by tag
```

## How It Works

The plugin detects Obsidian vaults by checking for the `.obsidian/` directory. When found:

1. **SessionStart hook** runs `vault-index.sh` to scan all `.md` files
2. Frontmatter is parsed to extract `tags` and `description` metadata
3. A table is output showing available documentation

Scripts use `fd` for file discovery and `rg` (ripgrep) for content search. Both are commonly available on developer machines.

## License

MIT
