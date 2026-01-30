# obsidian-claude

Claude Code integration for Obsidian vaults. Provides automatic vault indexing at session start and search tools for discovering documentation.

## Installation

```bash
claude plugins add ~/code/obsidian-claude
```

## Features

### Skills

The `/vault-search` skill provides two search modes:

- **Content Search** - Find documents containing specific words or phrases using ripgrep
- **Tag Search** - Find documents by frontmatter tag classification

A PreToolUse hook validates that `CLAUDE_OBSIDIAN_VAULT_DIRECTORY` is set before running searches.

### Environment Variable

Set `CLAUDE_OBSIDIAN_VAULT_DIRECTORY` to your vault path:

```bash
export CLAUDE_OBSIDIAN_VAULT_DIRECTORY=~/path/to/vault
```

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

Add this section to your vault's CLAUDE.md:

```markdown
## Vault Search

Use `/vault-search` to search vault content by text or tags.
```

## How It Works

1. User invokes `/vault-search`
2. PreToolUse hook validates `CLAUDE_OBSIDIAN_VAULT_DIRECTORY` is set
3. Skill provides scripts for content search (`vault-search.sh`) and tag search (`vault-search-tags.sh`)

Scripts use `fd` for file discovery and `rg` (ripgrep) for content search.

## License

MIT
