# vault-search

Search document content in an Obsidian vault using ripgrep.

## Usage

```bash
vault-search <pattern> [vault_dir]
```

## Arguments

- `pattern` - The search pattern (required)
- `vault_dir` - Directory to search (optional, defaults to current directory)

## Output

Returns matching lines grouped by file, with metadata headers showing:
- **Name**: Document filename (without .md extension)
- **Tags**: Tags from frontmatter
- **Description**: Description from frontmatter

## Example

Find all documents mentioning "nvidia":
```bash
vault-search nvidia
```

## Script Reference

```bash
${CLAUDE_PLUGIN_ROOT}/scripts/vault-search "$@"
```
