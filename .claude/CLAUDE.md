# Global instructions

- Whenever you write a markdown (`.md`) file, run `mdview <file>` on it afterward to open it in the browser for the user to review.
- Never include a "Co-Authored-By: Claude" (or similar Claude/Anthropic attribution) line in git commit messages.
- Whenever working in a git or yadm repo, always check status first (e.g. `git status` / `yadm status`) before acting — never assume what is staged, committed, or which branch is checked out.
- Whenever working in a git repo, always commit changes to a feature branch, never directly to the default branch (e.g. `main` or `master`). If currently on the default branch, create/switch to a feature branch before committing. Exception: the yadm dotfiles repo, which is committed to `main` directly per its normal workflow.
