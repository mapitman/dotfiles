# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

# Add .dotnet to path
if ! [[ "$PATH" =~ "$HOME/.dotnet:" ]]
then
    PATH="$HOME/.dotnet:$PATH"
fi

if ! [[ "$PATH" =~ "$HOME/.dotnet/tools" ]]
then
    PATH="$PATH:/home/mark/.dotnet/tools"
fi

export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions


# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

GOPATH="$HOME/go"
function _update_ps1() {
    PS1="$($GOPATH/bin/powerline-go -error $?)"
}

case "$OSTYPE" in
   msys)
        source ~/.bashrc_windows
   	    ;;
   darwin*)
        if [ -e $HOME/.dotnet ]
        then
            export DOTNET_ROOT="$HOME/.dotnet"
        fi

        export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
        ;;
   linux*)
        if [[ "$TERM" != "linux" ]] && [[ -f "$GOPATH/bin/powerline-go" ]]; then
            PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
        else
            PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
        fi

        if [ -e $HOME/.dotnet ]
        then
            export DOTNET_ROOT="$HOME/.dotnet"
        fi
        ;;
esac



# Variables

export GIT_PROMPT_ONLY_IN_REPO=1
export EDITOR="vim"
export VISUAL="$EDITOR"
export _JAVA_AWT_WM_NONREPARENTING=1

# Source other config files
if [ -e ~/.bash_aliases ]
then
    source ~/.bash_aliases
fi

#if [ -e ~/.bash-git-prompt/gitprompt.sh ]
#then
#    source ~/.bash-git-prompt/gitprompt.sh
#elif [ -e /usr/lib/bash-git-prompt/gitprompt.sh ]
#then
#    source /usr/lib/bash-git-prompt/gitprompt.sh
#fi



if [[ -e /usr/share/bash-completion/completions/git ]]
then
    source /usr/share/bash-completion/completions/git
fi

if [[ -e $HOME/.local/etc/bash_completion.d/git-extras ]]
then
    source .local/etc/bash_completion.d/git-extras
elif [[ -e /usr/share/bash_completion/git-extras ]]
then
    source /usr/share/bash_completion/git-extras
elif [[ -e /etc/bash_completion.d/git-extras ]]
then
    source /etc/bash_completion.d/git-extras
fi

if [[ -e /usr/share/autojump/autojump.bash ]]
then
    source /usr/share/autojump/autojump.bash
fi

source ~/.bash_functions

# Setup my PATH
PATH="$PATH:$HOME/bin:/usr/local/go/bin:$GOPATH/bin:$HOME/sdk/flutter/bin:$HOME/sdk/android-studio/bin:/snap/bin"
if [[ -d $HOME/.local/bin ]]
then
    PATH="$HOME/.local/bin:$PATH"
fi

# Source my file with some private info that I do not want exposed on GitHub
if [[ -e ~/.private ]]; then source ~/.private; fi

# Only start TMUX if it isn't already started, I'm not in an SSH session and not running on WSL
if [[ -z "$TMUX" ]] && [[ -z "$SSH_CLIENT" ]] && [[ -z "$SSH_TTY" ]] && [[ $(uname -a | grep -v -q microsoft) ]]
then
    exec tmux
fi

