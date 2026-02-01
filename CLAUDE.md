# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Claude Code plugin for Obsidian vaults. Provides the `/obsidian` skill for searching vault content and authoring notes with consistent formatting.

## Architecture

```
.claude-plugin/
  plugin.json       # Plugin metadata
  marketplace.json  # Marketplace listing
hooks/
  hooks.json        # SessionStart hook for vault detection
scripts/
  detect-vault.sh   # SessionStart: detects vault, injects system-reminder
  init.sh           # Initialization: validates vault + shows document index
  vault-search.sh   # Content search via ripgrep
  vault-search-tags.sh  # Tag search via fd + awk
skills/
  obsidian/
    SKILL.md        # Skill definition with search tools and authoring guidelines
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
