# Copilot Instructions

This is a personal dotfiles repository managed with [YADM](https://yadm.io/) (Yet Another Dotfiles Manager). The working tree is `$HOME` itself — tracked files live directly at their real paths.

## YADM Basics

- `yadm list` — show all tracked files
- `yadm add <file>` / `yadm commit` / `yadm push` — standard git-like workflow
- `yadm status` — see what's changed
- After cloning on a new machine, run `yadm alt` to apply any alternate file templates.

## Environment & Tooling

- **Shell**: Zsh + Oh-My-Zsh + starship prompt. Config in `~/.zshrc`.
- **Terminal**: Ghostty (`~/.config/ghostty/config`) — catppuccin-mocha theme, 0.9 background opacity.
- **Window manager**: Hyprland — bindings in `~/.config/hypr/bindings.conf`, autostart in `autostart.conf`, input in `input.conf`.
- **Editor**: Vim (`~/.vimrc`) — catppuccin mocha colorscheme, 4-space tabs (`expandtab`), line numbers, `ignorecase`/`smartcase`.
- **Multiplexer**: tmux (`~/.tmux.conf`) — prefix is `C-w` (not `C-a`); `\\`/`-` splits; Alt+arrows navigate panes; `C-S-Left/Right` cycles windows.
- **Version managers**: nvm (Node), pyenv (Python), mise (polyglot), all sourced conditionally in `.zshrc`.
- **PATH helpers**: `_path_prepend` / `_path_append` functions guard against duplicate entries on shell reload.
- **Theme**: Catppuccin Mocha throughout (Ghostty, Vim, Zsh syntax highlighting via `~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh`, LS_COLORS via `vivid`).

## Git Conventions

The commit template (`~/.git-commit-template`) enforces this style:
- Subject: imperative mood, ≤ 50 chars, capitalised, no trailing period
- Blank line between subject and body
- Body wraps at 72 chars; explains *what* and *why*, not how
- `git pull` rebases by default (`pull.rebase = true`)
- `push.autoSetupRemote = true` — no need for `-u origin <branch>` on first push

## Key `.zshrc` Sections

1. Oh-My-Zsh + plugins (autosuggestions, docker, syntax-highlighting, web-search, copybuffer)
2. Environment/PATH setup with conditional guards
3. Tool initialization (nvm, pyenv, mise, zoxide, fzf, vivid, starship) — all guarded with `command -v` / `type` checks
4. tmux auto-attach at the bottom (skipped inside tmux, SSH, and VS Code terminal)
5. `~/.private` sourced last for machine-local secrets/overrides
