# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
# ZSH_THEME="fox"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-autosuggestions docker zsh-syntax-highlighting aws)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

if ! [[ "$PATH" =~ "$HOME/go/bin" ]]
then
    PATH="$HOME/go/bin:$PATH"
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

# Add DOTNETROOT only if a user installation of .NET Core exists
if [ -e $HOME/.dotnet ]
then
    export DOTNET_ROOT="$HOME/.dotnet"
fi

# Variables

export EDITOR="vim"
export VISUAL="$EDITOR"
export _JAVA_AWT_WM_NONREPARENTING=1
export GOPATH="$HOME/go"

case "$OSTYPE" in
    msys)
        export TERM=cygwin
        export WINPROGRAMFILESX86="Program Files (x86)"
        export PROGRAMFILESX86="Program\ Files\ \(x86\)"
        export USER=$USERNAME
        export MSYS=winsymlinks:nativestrict
        export PYTHONPATH=$PYTHONPATH:/usr/lib/python3.8/site-packages
   	    ;;
    darwin*)
        export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
esac

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

        # https://github.com/mapitman/pi-ticker
        alias zoomdetector="pushd ~/src/github/mapitman/pi-ticker && ./zoom-detector.py"

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
alias zshrc="vim ~/.zshrc && source ~/.zshrc"

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

fpath+=$HOME/.zsh/functions
autoload -Uz compinit && compinit


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
    if [ -e ${files[@]:0:1} ]
    then
        eval $rider ${files[@]:0:1} >/dev/null 2>&1 &
    else
        files=(./*.csproj)
        if [ -e ${files[@]:0:1} ]
        then
            eval $rider ${files[@]:0:1} >/dev/null 2>&1 &
        fi
    fi
}


# Visual Studio complains about TMP, tmp, TEMP and temp all being set
unset tmp
unset temp

export AWS_SDK_LOAD_CONFIG=1

# z - Similar to autojump
# Works better in MSYS2
_Z_CMD=j
. ~/.local/bin/z.sh

# zsh parameter completion for the dotnet CLI
_dotnet_zsh_complete()
{
  local completions=("$(dotnet complete "$words")")
  reply=( "${(ps:\n:)completions}" )
}

compctl -K _dotnet_zsh_complete dotnet

# Prompt theme
fpath+=$HOME/.zsh/pure

autoload -U promptinit; promptinit
prompt pure

autoload -U bashcompinit
bashcompinit

