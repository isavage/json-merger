# JSON Merger

Privacy-first JSON file merger — runs entirely in your browser. Zero server, zero dependencies, zero uploads.

## Features

- **Drag & drop** or click-to-select multiple `.json` files
- **Deep merge engine**: objects recurse, arrays concatenate, last-wins on key conflicts
- **"Nest duplicates" toggle**: instead of overwriting, duplicate keys become `[oldValue, newValue]` arrays
- **Live syntax-highlighted preview** of the merged output before download
- **JSON.parse error detection** with line number and code snippet pointing to the exact bad character
- **Non-blocking warnings** for common mistakes (null result, bare strings/numbers)
- **Copy to clipboard** + one-click `merged.json` download
- **Pure client-side**: no network requests after page load, no data ever leaves your machine

## Quick Start

```bash
# Open directly
open index.html   # macOS / Linux
start index.html  # Windows

# Or serve via Docker Compose
docker compose up --build
# → http://localhost:3000
```

## Merge Rules

| Source A | Source B | Result |
|----------|----------|--------|
| `{}` + `{}` | Nested object merge | Keys combined recursively |
| `[]` + `[]` | Array concatenation | All elements preserved |
| String | Number | Last wins (`123`) |
| Object | Any | Last wins |
| Same key, both objects | Recursive deep merge | Sub-keys combined |
| Same key, different type | NestDuplicates OFF | Last wins |
| Same key, different type | NestDuplicates ON | `[a, b]` array |

## Error Handling

The parser detects malformed JSON and shows:
- **File name** that failed
- **Exact error message** from the engine
- **Line number** and **code snippet** at the error position
- Non-parseable file extensions are rejected upfront with a red banner

Common issues caught:
- Trailing commas (not valid JSON)
- Single quotes instead of double quotes
- Comments in JSON
- Bare strings/numbers where objects were expected

## Architecture

Single HTML file (~28 KB). Everything is vanilla JavaScript — no build step, no framework, no CDN. The file reads with `FileReader`, parses with native `JSON.parse`, merges with a recursive `deepMerge()`, and outputs via `Blob` + `URL.createObjectURL`.

## License

MIT
