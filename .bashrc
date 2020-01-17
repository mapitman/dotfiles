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

case "$OSTYPE" in
   msys)
        source ~/.bashrc_windows
   	    ;;
   darwin*)
        export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
        ;;
   linux*)
        PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]\$ '
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

if [ -e ~/.bash-git-prompt/gitprompt.sh ]
then
    source ~/.bash-git-prompt/gitprompt.sh
elif [ -e /usr/lib/bash-git-prompt/gitprompt.sh ]
then
    source /usr/lib/bash-git-prompt/gitprompt.sh
fi

if [ -e /usr/share/bash-completion/completions/git ]
then
    source /usr/share/bash-completion/completions/git
fi

if [ -e /usr/share/bash_completion/git-extras ]
then
    source /usr/share/bash_completion/git-extras
elif [ -e /etc/bash_completion.d/git-extras ]
then
    source /etc/bash_completion.d/git-extras
fi

if [ -e /usr/share/autojump/autojump.bash ]
then
    source /usr/share/autojump/autojump.bash
fi

if [ -e $HOME/.dotnet ]
then
    export DOTNET_ROOT="$HOME/.dotnet"
fi

source ~/.bash_functions

GOPATH="$HOME/go"

PATH="$PATH:$HOME/bin:/usr/local/go/bin:$GOPATH/bin:$HOME/sdk/flutter/bin:$HOME/sdk/android-studio/bin:/snap/bin"

# Things specific to WSL on Windows
if uname -a | grep -q Microsoft
then
    export DOCKER_HOST=tcp://0.0.0.0:2375
fi

if [ -e ~/.private ]; then source ~/.private; fi

if [ -z "$TMUX" ] && [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ]
then
    exec tmux
fi

