# obsidian-claude

Claude Code integration for Obsidian vaults. Provides automatic vault indexing at session start, search tools for discovering documentation, and authoring guidance for consistent note creation.

## Installation

```bash
claude plugins add ~/code/obsidian-claude
```

## Features

### Skills

The `/obsidian` skill provides:

- **Content Search** - Find documents containing specific words or phrases using ripgrep
- **Tag Search** - Find documents by frontmatter tag classification
- **Authoring Guidance** - Frontmatter, callouts, wiki links, and best practices for writing vault notes

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
## Vault Discovery

Vault indexing and search provided by the `obsidian` plugin from `obsidian-claude` marketplace. Use `/obsidian` skill to search vault content and see authoring guidelines.
```

## How It Works

1. User invokes `/obsidian`
2. PreToolUse hook validates `CLAUDE_OBSIDIAN_VAULT_DIRECTORY` is set
3. Skill provides scripts for content search (`vault-search.sh`) and tag search (`vault-search-tags.sh`)
4. Skill includes authoring guidelines for consistent note creation

Scripts use `fd` for file discovery and `rg` (ripgrep) for content search.

## License

MIT
