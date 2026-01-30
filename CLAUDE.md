# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Claude Code plugin for searching Obsidian vaults. Provides the `/vault-search` skill with content and tag search modes.

## Architecture

```
.claude-plugin/
  plugin.json       # Plugin metadata
  marketplace.json  # Marketplace listing
hooks/
  hooks.json        # Hook definitions (PreToolUse validation)
scripts/
  validate-vault.sh # PreToolUse hook - blocks if no vault configured
  vault-index.sh    # Index generator (unused currently)
  vault-search.sh   # Content search via ripgrep
  vault-search-tags.sh  # Tag search via fd + awk
skills/
  vault-search/
    SKILL.md        # Skill definition with YAML frontmatter
```

## Key Environment Variable

`CLAUDE_OBSIDIAN_VAULT_DIRECTORY` - Path to Obsidian vault. Falls back to `$PWD` if unset.

## Dependencies

Scripts require `fd` and `rg` (ripgrep) to be installed.

## Testing

No test framework. Test scripts manually against an Obsidian vault:

```bash
CLAUDE_OBSIDIAN_VAULT_DIRECTORY=~/vault ./scripts/vault-search.sh "pattern"
CLAUDE_OBSIDIAN_VAULT_DIRECTORY=~/vault ./scripts/vault-search-tags.sh "tag"
```
