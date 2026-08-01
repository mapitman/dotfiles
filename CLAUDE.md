# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository overview

This is a personal dotfiles repository managed with [YADM](https://yadm.io/) (Yet Another Dotfiles Manager). The working tree is `$HOME` itself — tracked files live directly at their real paths (e.g. `~/.zshrc`, `~/.vimrc`), interspersed with untracked personal files (Documents, Downloads, 3D-printing project files, etc.). Only files explicitly added to YADM are part of the repo (`yadm list` shows the current set); most of `$HOME` is untracked.

## Commands

YADM wraps git with an alternate git directory, so the underlying commands are git-like but must go through `yadm`, not `git`, for tracked dotfiles.

This repo is committed to `main` directly per its normal workflow (not feature branches).

## Commit conventions

Subject/body rules are enforced by the commit template at `~/.git-commit-template` (wired via `git config commit.template`). Other relevant git behavior is set in `~/.gitconfig` (`pull.rebase`, `push.autoSetupRemote`, `init.defaultBranch`).

## `.zshrc` structure

1. Oh-My-Zsh + plugins
2. Environment/PATH setup with conditional guards
3. Tool initialization (nvm, pyenv, mise, zoxide, fzf, vivid, starship) — all guarded with `command -v` / `type` checks
4. `~/.private` sourced near the end for machine-local secrets/overrides — never commit this file's contents into tracked config
5. tmux auto-attach at the very bottom (skipped when already inside tmux, over SSH, or in the VS Code terminal)

## Tracked `.claude/` files

`.claude/.gitignore` whitelists only `.gitignore`, `CLAUDE.md`, `settings.json`, `statusline-command.sh`, and `themes/custom-dark.json` for tracking — everything else under `~/.claude` (sessions, caches, credentials) is intentionally untracked. When editing Claude Code config in this repo, stay within that whitelist rather than trying to track other files under `~/.claude`.
