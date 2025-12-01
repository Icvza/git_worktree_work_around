# symLinkWorkTree

`symLinkWorkTree` is a tiny helper binary that copies a source file (usually an `.env`) into a git worktree directory so you do not have to manually recreate the file every time you spin up a new worktree.

## How it works

1. Read the file located at the origin path you pass in as the first argument
2. Make sure the destination directory exists
3. Write a file in that directory using the same filename as the original

In effect, `symLinkWorkTree /path/to/.env ~/worktrees/feature-x/apps/site` will create `~/worktrees/feature-x/apps/site/.env` that mirrors the source file's contents.

## Build & install

```bash
cargo build --release
# Optional: move the binary somewhere on your PATH
cp target/release/symLinkWorkTree ~/.local/bin/
```

## Usage

```bash
symLinkWorkTree <path-to-source-file> <target-directory>
```

- The destination must be a directory; the program automatically appends the source filename.
- Both paths must exist and be readable/writable by the user running the command.

## Example shell helper

The repository includes `example.zshrc` showing how to wire the binary into a helper function that adds git worktrees and immediately copies the required `.env` files:

```zsh
symLinkWorkTree "$GT_APP_ENV_SOURCE" "$worktree_path/apps/site"
symLinkWorkTree "$GT_SS_UI_ENV_SOURCE" "$worktree_path/packages/se-supersonic-ui"
```

Set the `GT_*` environment variables to the paths of the canonical `.env` files in your main checkout, then source the helper in your shell startup script to keep every worktree ready-to-run.

## Troubleshooting

- Ensure the binary is on your `PATH` so any shell function can invoke it.
- Run with full paths to avoid resolving symbolic links incorrectly.
- If the destination file already exists it will be overwritten; create backups if needed.
