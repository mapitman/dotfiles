# =============================================================================
# Oh-My-Zsh
# =============================================================================

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh

plugins=(zsh-autosuggestions docker zsh-syntax-highlighting web-search copybuffer)

source $ZSH/oh-my-zsh.sh

# =============================================================================
# Environment
# =============================================================================

export XDG_DATA_DIRS=$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:/home/mark/.local/share/flatpak/exports/share
export XDG_CONFIG_HOME=$HOME/.config

if [ -e /home/linuxbrew/.linuxbrew/bin ]
then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Set up a writable tmp directory so mdview can work with snap-installed browsers
if [ -f /etc/os-release ] && grep -qi ubuntu /etc/os-release
then
    if [ ! -d "$HOME/tmp" ]
    then
        mkdir -p "$HOME/tmp"
    fi
    export TMPDIR="$HOME/tmp"
fi

# PATH additions (guard against duplicates on shell reload)
_path_prepend() { [[ ":$PATH:" != *":$1:"* ]] && PATH="$1:$PATH"; }
_path_append()  { [[ ":$PATH:" != *":$1:"* ]] && PATH="$PATH:$1"; }

_path_prepend "$HOME/.local/bin"
_path_prepend "$HOME/bin"
_path_prepend "$HOME/go/bin"
_path_prepend "$HOME/.cargo/bin"
[[ -e "$HOME/.tfenv/bin" ]]                        && _path_prepend "$HOME/.tfenv/bin"
[[ -e "$HOME/.local/tfenv/bin" ]]                  && _path_prepend "$HOME/.local/tfenv/bin"
[[ -e "$HOME/.dotnet/tools" ]]                     && _path_append  "$HOME/.dotnet/tools"
[[ -e "$HOME/.local/share/flatpak/exports/bin" ]]  && _path_append  "$HOME/.local/share/flatpak/exports/bin"
[[ -e "/var/lib/flatpak/exports/bin" ]]            && _path_append  "/var/lib/flatpak/exports/bin"
[[ -e "$HOME/android-studio/bin" ]]                && _path_append  "$HOME/android-studio/bin"
[[ -e "$HOME/Android/Sdk/cmdline-tools/bin" ]]     && _path_append  "$HOME/Android/Sdk/cmdline-tools/bin"

export PATH

[[ ":$MANPATH:" != *":$HOME/.local/share/man:"* ]] && MANPATH="$HOME/.local/share/man:$MANPATH"

export EDITOR="vim"
export VISUAL="$EDITOR"
export GOPATH="$HOME/go"
export _JAVA_AWT_WM_NONREPARENTING=1  # Required for Java GUIs on tiling WMs
export MOZ_ENABLE_WAYLAND=1

# =============================================================================
# Aliases
# =============================================================================

# ls
if command -v eza >/dev/null 2>&1
then
    alias ls=eza
else
    alias ls='ls --color=auto'
fi
alias ll="ls -lh"

# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Navigation & shell
alias h="cd ~"
alias xclip='xclip -selection clipboard'
alias printenv='printenv | grep -v LS_COLORS | sort'

# Config editing shortcuts
alias zshrc="vim ~/.zshrc && omz reload"
if [[ $XDG_SESSION_DESKTOP = "hyprland" ]]
then
    alias hyprconf="vim ~/.config/hypr/hyprland.conf"
    alias waybarconf="vim ~/.config/waybar/config"
fi

# Git
alias branchowners="git for-each-ref --format='%(committerdate) %09 %(authorname) %09 %(refname)' | sort -k5n -k2M -k3n -k4n | grep remotes | grep -v HEAD | grep -v fi | grep -v master"

# Tools
alias tf=terraform
alias gosrc="cd $GOPATH/src/"
alias redis-cli='docker run --rm -it mapitman/redis-cli'
alias new-guid="pwsh -c New-Guid"
alias wgup='sudo wg-quick up wg0'
alias wgdown='sudo wg-quick down wg0'
alias topten="history | awk '{print \$2}' | sort | uniq -c | sort -rn | head -n 10"

# Desktop notification on completion of a long-running command: `sleep 10; alert`
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Safe file removal via gio trash
if command -v gio > /dev/null
then
    alias trash='gio trash'
fi

# =============================================================================
# Functions
# =============================================================================

# Distro-aware system update
if [ -f "/etc/os-release" ]
then
    update() {
        if grep -Fiq "ubuntu" /etc/os-release
        then
            if type snap > /dev/null 2>&1; then echo 'Updating snaps...'; sudo snap refresh; fi
            if type flatpak > /dev/null 2>&1; then echo 'Updating Flatpaks...'; flatpak update; fi
            echo 'Updating packages...'
            if type nala > /dev/null 2>&1; then sudo nala upgrade; else sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y; fi
            if type deb-get > /dev/null 2>&1; then deb-get update; deb-get upgrade; fi
            omz update
        elif grep -Fiq "fedora" /etc/os-release
        then
            sudo dnf upgrade -y
            omz update
        elif grep -Fiq "arch" /etc/os-release
        then
            yay -Syu --noconfirm
            omz update
        elif grep -Fiq "debian" /etc/os-release
        then
            if type flatpak > /dev/null 2>&1; then echo 'Updating Flatpaks...'; flatpak update; fi
            sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y
            if type deb-get > /dev/null 2>&1; then deb-get update; deb-get upgrade; fi
            omz update
        else
            echo "update: unsupported Linux distribution"
            return 1
        fi
    }
fi

# Show load averages in a readable format
loadavg() {
    awk '{ printf("1-minute: %s\n5-minute: %s\n15-minute: %s\n",$1,$2,$3); }' /proc/loadavg
}

# Open the nearest .sln or .csproj with JetBrains Rider via xdg-open
rider() {
    local files=(./*.sln(N))
    if [[ -e ${files[@]:0:1} ]]
    then
        echo "opening ${files[@]:0:1}..."
        xdg-open ${files[@]:0:1} >/dev/null 2>&1 &
    else
        files=(./*.csproj(N))
        if [[ -e ${files[@]:0:1} ]]
        then
            echo "opening ${files[@]:0:1}..."
            xdg-open ${files[@]:0:1} >/dev/null 2>&1 &
        fi
    fi
}

# Delete all local branches except the repo default
rm-branches() {
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1
    then
        echo "Not a Git repository."
        return 1
    fi
    local default_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
    for branch in $(git branch --list | grep -v "$default_branch")
    do
        git branch -D "$branch"
    done
}

# Show onefetch repo summary when entering a new git repository
last_repository=
check_directory_for_new_repository() {
    current_repository=$(git rev-parse --show-toplevel 2>/dev/null)
    if [ "$current_repository" ] && \
       [ "$current_repository" != "$last_repository" ] && \
       type onefetch >/dev/null 2>&1
    then
        onefetch
    fi
    last_repository=$current_repository
}

cd() {
    builtin cd "$@"
    check_directory_for_new_repository
}

# =============================================================================
# Completions
# =============================================================================

fpath+=$HOME/.zsh/functions
fpath+=~/.zfunc
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# Terraform
complete -o nospace -C /usr/bin/terraform terraform

# dotnet CLI tab completion
_dotnet_zsh_complete() {
    local completions=("$(dotnet complete "$words")")
    reply=( "${(ps:\n:)completions}" )
}
compctl -K _dotnet_zsh_complete dotnet

# git-extras
if [[ -e "$HOME/.zsh/git-extras-completion.zsh" ]]
then
    source "$HOME/.zsh/git-extras-completion.zsh"
fi

zstyle ':completion:*' menu select

# Avoid slowdown when pasting with zsh-autosuggestions active
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
    OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
    zle -N self-insert url-quote-magic
}
pastefinish() {
    zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# =============================================================================
# Tool Initialization
# =============================================================================

# nvm — system install (e.g. Arch AUR)
if [[ -e "/usr/share/nvm/init-nvm.sh" ]]
then
    source /usr/share/nvm/init-nvm.sh
fi

# nvm — user install
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ]             && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ]    && source "$NVM_DIR/bash_completion"

# pyenv
if type pyenv > /dev/null 2>&1
then
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# mise (dev tools version manager)
if command -v mise > /dev/null 2>&1
then
    eval "$(mise activate zsh)"
fi

# zoxide (smarter cd)
eval "$(zoxide init zsh)"

# fzf
if command -v fzf > /dev/null 2>&1
then
    source <(fzf --zsh)
fi

# vivid (generates LS_COLORS for catppuccin theme)
if type vivid > /dev/null 2>&1
then
    export LS_COLORS="$(vivid generate catppuccin-mocha)"
fi

# Pango 1.56.x workaround for variable font crash
# See ~/.config/fontconfig/fonts-pango.conf
export FONTCONFIG_FILE="$HOME/.config/fontconfig/fonts-pango.conf"

# starship prompt
eval "$(starship init zsh)"

# =============================================================================
# Private / Local Config
# =============================================================================

if [[ -e ~/.private ]]; then source ~/.private; fi

# =============================================================================
# tmux Auto-attach (keep last — launches a new process)
# =============================================================================

# Automatically attach to (or create) a default tmux session.
# Skipped when already in tmux, an SSH session, or VS Code terminal.
if [[ $TERM_PROGRAM != "tmux" \
   && $TERM != "screen"* \
   && $TERM_PROGRAM != "vscode" \
   && -z "$SSH_CONNECTION" \
   && -z "$SSH_CLIENT" ]] \
   && command -v tmux > /dev/null 2>&1
then
    tmux attach -t default > /dev/null 2>&1 || tmux new -s default
fi
