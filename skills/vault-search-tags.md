# vault-search-tags

Find documents by tag in an Obsidian vault.

## Usage

```bash
vault-search-tags <tag> [vault_dir]
```

## Arguments

- `tag` - The tag to search for (required)
- `vault_dir` - Directory to search (optional, defaults to current directory)

## Output

Returns a table of matching documents:
- **File**: Document filename (without .md extension)
- **Tags**: All tags from frontmatter
- **Description**: Description from frontmatter

## Example

Find all documents tagged with "nvidia":
```bash
vault-search-tags nvidia
```

## Script Reference

```bash
${CLAUDE_PLUGIN_ROOT}/scripts/vault-search-tags "$@"
```
