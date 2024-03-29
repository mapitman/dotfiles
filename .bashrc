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
    PATH="$PATH:$HOME/.dotnet/tools"
fi

if ! [[ "$PATH" =~ "$HOME/.gem/ruby/2.7.0/bin" ]]
then
    PATH="$PATH:$HOME/.gem/ruby/2.7.0/bin"
fi

export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=


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

# Add DOTNETROOT only if a user installation of .NET Core exists
if [ -e $HOME/.dotnet ]
then
    export DOTNET_ROOT="$HOME/.dotnet"
fi

# Variables

export GIT_PROMPT_ONLY_IN_REPO=1
export GIT_PROMPT_FETCH_REMOTE_STATUS=0
export GIT_PROMPT_SHOW_UNTRACKED_FILES=normal
export EDITOR="vim"
export VISUAL="$EDITOR"
export _JAVA_AWT_WM_NONREPARENTING=1
export GOPATH="$HOME/go"

function _update_ps1() {
    PS1="$($GOPATH/bin/powerline-go -error $? -newline -condensed -cwd-mode plain -colorize-hostname)"
}

fast_git_ps1 ()
{
    printf -- "$(git branch 2>/dev/null | grep -e '\* ' | sed 's/^..\(.*\)/ [\1] /')"
}

case "$OSTYPE" in
    msys)
        export TERM=xterm-256color
        export TERM=cygwin
        export WINPROGRAMFILESX86="Program Files (x86)"
        export PROGRAMFILESX86="Program\ Files\ \(x86\)"
        export USER=$USERNAME
        export MSYS=winsymlinks:nativestrict
        export PYTHONPATH=$PYTHONPATH:/usr/lib/python3.8/site-packages
        #export PS1='\[\033]0;$MSYSTEM:\w\007\033[32m\]\u@\h \[\033[01;33m\w$(fast_git_ps1)\033[0m\]
#\$ '
        export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
   	    ;;
    darwin*)
        export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
        export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
        ;;
    linux*)
        export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
esac

if [ -e ~/.bash-git-prompt/gitprompt.sh ]
then
   source ~/.bash-git-prompt/gitprompt.sh
elif [ -e /usr/lib/bash-git-prompt/gitprompt.sh ]
then
   source /usr/lib/bash-git-prompt/gitprompt.sh
fi

if [[ -e /usr/share/bash-completion/completions/git ]]
then
    source /usr/share/bash-completion/completions/git
fi

if [[ -e $HOME/.local/etc/bash_completion.d/git-extras ]]
then
    source $HOME/.local/etc/bash_completion.d/git-extras
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

# z - Similar to autojump
_Z_CMD=j
. ~/.local/bin/z.sh

# Setup my PATH
PATH="$PATH:$HOME/bin:/usr/local/go/bin:$GOPATH/bin:$HOME/sdk/flutter/bin:$HOME/sdk/android-studio/bin:/snap/bin"
if [[ -d $HOME/.local/bin ]]
then
    PATH="$HOME/.local/bin:$PATH"
fi

if [[ -d /usr/local/lib/python3.7/site-packages ]]
then
    export PYTHONPATH=/usr/local/lib/python3.7/site-packages
fi

# Aliases and functions

case "$OSTYPE" in
    msys)
        alias open="start"
        alias msbuild='/c/Program\ Files\ \(x86\)/Microsoft\ Visual\ Studio/2019/Professional/MSBuild/Current/Bin/msbuild.exe'
        alias winget='pwsh -c $LOCALAPPDATA/Microsoft/WindowsApps/winget'
        alias build="msbuild build.proj"
        alias b="build"
        alias cb="git clean -dxf && build"
        alias edit-hosts='sudo vim /C/Windows/System32/drivers/etc/hosts'
        alias bind="docker run -it --rm mapitman/bind-utils"
        alias more=less
        alias dotnet="/c/Program\ Files/dotnet/dotnet.exe"
        alias cpawscreds='cp $USERPROFILE/.aws/credentials ~/.aws/credentials'
        alias zoomdetector="pushd ~/src/github/mapitman/pi-ticker && ./zoom-detector.py"
        alias z="exec zsh"

        vs ()
        {
            files=(./*.sln)
            if [ -e ${files[0]} ]
            then
                start ${files[0]}
            else
                files=(./*.csproj)
                if [ -e ${files[0]} ]
                then
                    start ${files[0]}
                fi
            fi
        }

        sudovs ()
        {
            files=(./*.sln)
            if [ -e ${files[0]} ]
            then
                sudo start ${files[0]}
            else
                files=(./*.csproj)
                if [ -e ${files[0]} ]
                then
                    sudo start ${files[0]}
                fi
            fi
        }

        dig () {
            docker run -it --rm mapitman/linux-tools dig $@
        }
        host () {
            docker run -it --rm mapitman/linux-tools host $@
        }

        pwgen () {
            docker run -it --rm  mapitman/linux-tools pwgen "$@"
        }

        telnet () {
            docker run -it --rm mapitman/linux-tools telnet "$@";
        }

        nc () {
            docker run -it --rm mapitman/linux-tools nc "$@";
        }
   	    ;;
    linux*)
        alias start="xdg-open"
        alias open="xdg-open"
        alias ls='ls --color=auto'
        alias xclip='xclip -selection clipboard'
        ;;
    darwin*)
        alias start="open"
        alias xclip='pbcopy'
        alias dotnet="TERM=xterm dotnet"
        ;;
esac

alias ll="ls -l"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias bashrc="vim ~/.bashrc && source ~/.bashrc"
alias h="cd ~"
alias clear='printf "\33[2J"'
alias cclear='/usr/bin/clear'
alias cls='clear'
alias printenv='printenv | grep -e LS_COLORS -v | sort'
alias wgup='sudo wg-quick up wg0'
alias wgdown='sudo wg-quick down wg0'

if which bat >/dev/null 2>&1 
then
    alias cat=bat
elif which batcat >/dev/null 2>&1
then
    alias cat=batcat
fi
alias branchowners="git for-each-ref --format='%(committerdate) %09 %(authorname) %09 %(refname)' | sort -k5n -k2M -k3n -k4n | grep remotes | grep -v HEAD | grep -v fi | grep -v master"
alias gosrc="cd $GOPATH/src/"
alias tf=terraform

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias mitmproxy="docker run --rm -it -v ~/.mitmproxy:/home/mitmproxy/.mitmproxy -p 8080:8080 mitmproxy/mitmproxy"
alias mitmweb="docker run --rm -it -v ~/.mitmproxy:/home/mitmproxy/.mitmproxy -p 8080:8080 -p 8081:8081 mitmproxy/mitmproxy mitmweb --web-iface 0.0.0.0"
alias topten="history | awk '{print $2}' | sort | uniq -c | sort -rn | head -n 10"
alias redis-cli='docker run --rm -it mapitman/redis-cli'

# if uname -a | grep -q Microsoft || uname -a | grep -q Ubuntu
if [ -f "/etc/os-release" ]
then
    if grep -Fiq "ubuntu" /etc/os-release
    then
        alias update="if type snap > /dev/null 2>&1; then echo 'Updating snaps...'; sudo snap refresh; fi; if type flatpak > /dev/null 2>&1; then echo 'Updating Flatpaks...'; sudo flatpak update; fi; echo 'Updating packages...'; sudo apt-get update && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y"   
    elif grep -Fiq "fedora" /etc/os-release
    then 
        alias update="sudo dnf upgrade -y"
    elif grep -Fiq "arch" /etc/os-release
    then
        alias update="yay -Syu --noconfirm"
    fi
else
    alias update="pacman -Syu --noconfirm"
fi

# Source my file with some private info that I do not want exposed on GitHub
if [[ -e ~/.private ]]; then source ~/.private; fi

function loadavg() {
    awk '{ printf("1-minute: %s\n5-minute: %s\n15-minute: %s\n",$1,$2,$3); }' /proc/loadavg
}

rider ()
{
    case "$OSTYPE" in
        msys)
            rider="start rider64"
        ;;
        linux*)
            rider=$HOME/rider/bin/rider.sh
        ;;
        darwin*)
            rider=/usr/local/bin/rider
        ;;
    esac

    files=(./*.sln)
    if [ -e ${files[0]} ]
    then
        eval $rider ${files[0]} >/dev/null 2>&1 &
    else
        files=(./*.csproj)
        if [ -e ${files[0]} ]
        then
            eval $rider ${files[0]} >/dev/null 2>&1 &
        fi
    fi
}

# Visual Studio complains about TMP, tmp, TEMP and temp all being set
unset tmp
unset temp

export AWS_SDK_LOAD_CONFIG=1

complete -C /usr/bin/terraform terraform
