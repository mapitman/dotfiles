# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
 ZSH_THEME=""
# ZSH_THEME="robbyrussell"
#ZSH_THEME="bira"

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
DISABLE_AUTO_UPDATE="true"

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
plugins=(zsh-autosuggestions docker zsh-syntax-highlighting web-search copybuffer z)

source $ZSH/oh-my-zsh.sh

# User configuration

case "$OSTYPE" in
    msys)
        export TERM=cygwin
        export WINPROGRAMFILESX86="Program Files (x86)"
        export PROGRAMFILESX86="Program\ Files\ \(x86\)"
        export USER=$USERNAME
        export MSYS=winsymlinks:nativestrict
        export PYTHONPATH=$PYTHONPATH:/usr/lib/python3.10/site-packages
   	    ;;
    linux*)
        export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/mark/.local/share/flatpak/exports/share
        if [ -e /home/linuxbrew/.linuxbrew/bin ]
        then
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        fi
        ;;
    darwin*)
        export PATH="/opt/homebrew/bin:/usr/local/opt/coreutils/libexec/gnubin:$PATH"
        export PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/3.3.0/bin:$PATH"
        export HOMEBREW_NO_ENV_HINTS=1
        export DOCKER_HOST="unix://$HOME/.colima/docker.sock"
esac
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

if ! [[ "$PATH" =~ "$HOME/.dotnet/tools" ]]
then
    PATH="$PATH:$HOME/.dotnet/tools"
fi

if ! [[ "$PATH" =~ "$HOME/.gem/ruby/2.7.0/bin" ]]
then
    PATH="$PATH:$HOME/.gem/ruby/2.7.0/bin"
fi

if [[ -e $HOME/.local/share/gem/ruby/3.0.0/bin ]]
then
   if ! [[ "$PATH" =~ "$HOME/.local/share/gem/ruby/3.0.0/bin" ]] 
   then
       PATH="$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin"
   fi
fi

if [[ -e $HOME/.local/tfenv/bin ]]
then
   if ! [[ "$PATH" =~ "$HOME/.local/tfenv/bin" ]] 
   then
       PATH="$PATH:$HOME/.local/tfenv/bin"
   fi
fi
# Flatpak helpers
if [[ -e $HOME/.local/share/flatpak/exports/bin ]]
then
    if ! [[ "$PATH" =~ "$HOME/.local/share/flatpak/exports/bin" ]]
    then
        PATH=$PATH:$HOME/.local/share/flatpak/exports/bin
    fi
fi

if [[ -e /var/lib/flatpak/exports/bin ]]
then
    if ! [[ "$PATH" =~ "$/var/lib/flatpak/exports/bin" ]]
    then
        PATH=$PATH:/var/lib/flatpak/exports/bin
    fi
fi

if [[ -e "$HOME/.tfenv/bin" ]]
then
    if ! [[ "$PATH" =~ "$HOME/.tfenv/bin" ]]
    then
        PATH="$HOME/.tfenv/bin:$PATH"
    fi
fi

if [[ -e $HOME/android-studio/bin ]]
then
   if ! [[ "$PATH" =~ "$HOME/android-studio/bin" ]] 
   then
       PATH="$PATH:$HOME/android-studio/bin"
   fi
fi

if [[ -e $HOME/Android/Sdk/cmdline-tools/bin ]]
then
   if ! [[ "$PATH" =~ "$HOME/Android/Sdk/cmdline-tools/bin" ]] 
   then
       PATH="$PATH:$HOME/Android/Sdk/cmdline-tools/bin"
   fi
fi

if [[ -e $HOME/.cargo/bin ]]
then
    if ! [[ "$PATH" =~ "$HOME/.cargo/bin" ]]
    then
        PATH="$PATH:$HOME/.cargo/bin"
    fi
fi

export PATH

# Variables

export EDITOR="nvim"
export VISUAL="$EDITOR"
export _JAVA_AWT_WM_NONREPARENTING=1
export GOPATH="$HOME/go"
export MOZ_ENABLE_WAYLAND=1



# Aliases and functions

case "$OSTYPE" in
    msys)
        alias open="start"
        # alias msbuild='/c/Program\ Files\ \(x86\)/Microsoft\ Visual\ Studio/2019/Professional/MSBuild/Current/Bin/msbuild.exe'
        alias msbuild='/c/Windows/Microsoft.NET/Framework/v4.0.30319/msbuild.exe'
        alias winget='pwsh -c $LOCALAPPDATA/Microsoft/WindowsApps/winget'
        alias build="msbuild build.proj"
        alias b="build"
        alias cb="git clean -dxf && build"
        alias edit-hosts='sudo vim /C/Windows/System32/drivers/etc/hosts'
        alias bind="docker run -it --rm mapitman/bind-utils"
        alias more=less
        #alias dotnet="/c/Program\ Files/dotnet/dotnet.exe"
        alias cpawscreds='cp $USERPROFILE/.aws/credentials ~/.aws/credentials'

        # https://github.com/mapitman/pi-ticker
        alias zoomdetector="pushd ~/src/github/mapitman/pi-ticker && ./zoom-detector.py"

        vs ()
        {
            files=(./*.sln(N))
            if [[ -e ${files[@]:0:1} ]]
            then
                echo "opening ${files[@]:0:1}..."
                eval start ${files[@]:0:1} >/dev/null 2>&1 &
            else
                files=(./*.csproj(N))
                echo "opening ${files[@]:0:1}..."
                if [[ -e ${files[@]:0:1} ]]
                then
                    eval start ${files[@]:0:1} >/dev/null 2>&1 &
                fi
            fi
        }

        sudovs ()
        {
            files=(./*.sln(N))
            if [[ -e ${files[@]:0:1} ]]
            then
                echo "opening ${files[@]:0:1}..."
                eval sudo start ${files[@]:0:1} >/dev/null 2>&1 &
            else
                files=(./*.csproj(N))
                echo "opening ${files[@]:0:1}..."
                if [[ -e ${files[@]:0:1} ]]
                then
                    eval sudo start ${files[@]:0:1} >/dev/null 2>&1 &
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
        alias ls='ls --color=auto'
        alias xclip='xclip -selection clipboard'
        if [[ $XDG_SESSION_DESKTOP = "hyprland" ]]
        then
            alias hyprconf="vim ~/.config/hypr/hyprland.conf"
            alias waybarconf="vim ~/.config/waybar/config"
        fi
        ;;
    darwin*)
        alias start="open"
        alias xclip='pbcopy'
        #alias dotnet="TERM=xterm dotnet"
        alias update="if type brew > /dev/null 2>&1; then brew update; brew upgrade; fi; omz update;"
        alias vim="nvim"
        ;;
esac

alias ll="ls -lh"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias bashrc="vim ~/.bashrc && exec bash"
alias h="cd ~"
alias clear='printf "\33[2J"'
alias cclear='/usr/bin/clear'
alias cls='clear'
alias printenv='printenv | grep -e LS_COLORS -v | sort'
alias wgup='sudo wg-quick up wg0'
alias wgdown='sudo wg-quick down wg0'
alias zshrc="vim ~/.zshrc && omz reload"
alias fix-main="git pull -p; git checkout main && git remote set-head origin -a"
alias rename-to-main="pwsh -Command Rename-GitlabProjectDefaultBranch main"
alias new-guid="pwsh -c New-Guid"
# alias j=z

if type bat >/dev/null 2>&1 
then
    alias cat=bat
elif type batcat >/dev/null 2>&1
then
    alias cat=batcat
fi
alias branchowners="git for-each-ref --format='%(committerdate) %09 %(authorname) %09 %(refname)' | sort -k5n -k2M -k3n -k4n | grep remotes | grep -v HEAD | grep -v fi | grep -v master"
alias gosrc="cd $GOPATH/src/"
alias tf=terraform

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#alias mitmproxy="docker run --rm -it -v ~/.mitmproxy:/home/mitmproxy/.mitmproxy -p 8080:8080 mitmproxy/mitmproxy"
#alias mitmweb="docker run --rm -it -v ~/.mitmproxy:/home/mitmproxy/.mitmproxy -p 8080:8080 -p 8081:8081 mitmproxy/mitmproxy mitmweb --web-iface 0.0.0.0"
alias topten="history | awk '{print $2}' | sort | uniq -c | sort -rn | head -n 10"
alias redis-cli='docker run --rm -it mapitman/redis-cli'

# if uname -a | grep -q Microsoft || uname -a | grep -q Ubuntu
if [ -f "/etc/os-release" ]
then
    if grep -Fiq "ubuntu" /etc/os-release
    then
        alias update="if type snap > /dev/null 2>&1; then echo 'Updating snaps...'; sudo snap refresh; fi; if type flatpak > /dev/null 2>&1; then echo 'Updating Flatpaks...'; flatpak update; fi; echo 'Updating packages...'; if type nala > /dev/null 2>&1; then sudo nala upgrade; else sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get autoremove -y; fi; if type deb-get > /dev/null 2>&1; then deb-get update; deb-get upgrade; fi; omz update"
        export MDVIEW_DIR=$HOME/mdview-temp
    elif grep -Fiq "fedora" /etc/os-release
    then 
        alias update="sudo dnf upgrade -y; omz update"
    elif grep -Fiq "msys2" /etc/os-release
    then
        alias update="pacman -Syu --noconfirm; omz update"
    elif grep -Fiq "arch" /etc/os-release
    then
        alias update="yay -Syu --noconfirm; omz update"
    fi
fi

fpath+=$HOME/.zsh/functions
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# Source my file with some private info that I do not want exposed on GitHub
if [[ -e ~/.private ]]; then source ~/.private; fi

function loadavg() {
    awk '{ printf("1-minute: %s\n5-minute: %s\n15-minute: %s\n",$1,$2,$3); }' /proc/loadavg
}

rider ()
{
    case "$OSTYPE" in
        msys)
            localappdata=`cygpath $LOCALAPPDATA`
            rider="$localappdata/JetBrains/Toolbox/scripts/Rider.cmd"
        ;;
        linux*)
            # Before this will work, the file types must be associated
            # https://www.jetbrains.com/help/rider/Creating_and_Registering_File_Types.html
            rider=xdg-open
        ;;
        darwin*)
            rider=$HOME/Applications/Rider.app/Contents/MacOS/rider
        ;;
    esac

    files=(./*.sln(N))
    if [[ -e ${files[@]:0:1} ]]
    then
        echo "opening ${files[@]:0:1}..."
        eval $rider ${files[@]:0:1} >/dev/null 2>&1 &
    else
        files=(./*.csproj(N))
        echo "opening ${files[@]:0:1}..."
        if [[ -e ${files[@]:0:1} ]]
        then
            eval $rider ${files[@]:0:1} >/dev/null 2>&1 &
        fi
    fi
}

function glab-run-branch() {
    glab ci run -b $(git rev-parse --abbrev-ref HEAD)
}

function rm-branches() {
    # Check if the current path is a Git repository
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "Not a Git repository. Exiting..."
        exit 1
    fi

    # Delete each branch except the default branch
    default_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
    for branch in $(git branch --list | grep -v $default_branch); do
        git branch -D $branch
    done
}

# Visual Studio complains about TMP, tmp, TEMP and temp all being set
unset tmp
unset temp

# zsh parameter completion for the dotnet CLI
_dotnet_zsh_complete()
{
  local completions=("$(dotnet complete "$words")")
  reply=( "${(ps:\n:)completions}" )
}

compctl -K _dotnet_zsh_complete dotnet




# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# use this if I'm not going to use the a prompt with built-in git support
#source $HOME/.zsh/async-git-prompt.plugin.zsh

if [[ -e "/usr/share/nvm/init-nvm.sh" ]]
then
    source /usr/share/nvm/init-nvm.sh
fi

if [[ -e "$HOME/.zsh/git-extras-completion.zsh" ]]
then
    source $HOME/.zsh/git-extras-completion.zsh
fi

complete -o nospace -C /usr/bin/terraform terraform

#compdef nala

_nala_completion() {
  eval $(env _TYPER_COMPLETE_ARGS="${words[1,$CURRENT]}" _NALA_COMPLETE=complete_zsh nala)
}

compdef _nala_completion nala


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# Safer alternatives to `rm`
if [[ $VENDOR == apple ]]; then
  trash() {
    local -aU items=( $^@(N) )
    local -aU missing=( ${@:|items} )
    (( $#missing )) &&
        print -u2 "trash: no such file(s): $missing"
    (( $#items )) ||
        return 66
    print Moving $( eval ls -d -- ${(q)items[@]%/} ) to Trash.
    items=( '(POSIX file "'${^items[@]:A}'")' )
    osascript -e 'tell application "Finder" to delete every item of {'${(j:, :)items}'}' \
        > /dev/null
  }
elif command -v gio > /dev/null; then
  # gio is available for macOS, but gio trash DOES NOT WORK correctly there.
  alias trash='gio trash'
fi

zstyle ':completion:*' menu select
fpath+=~/.zfunc

# git repository greeter
last_repository=
check_directory_for_new_repository() {
	current_repository=$(git rev-parse --show-toplevel 2> /dev/null)
	
	if [ "$current_repository" ] && \
	   [ "$current_repository" != "$last_repository" ] && \
       type onefetch > /dev/null 2>&1; then
		onefetch
	fi
	last_repository=$current_repository
}

cd() {
	builtin cd "$@"
	check_directory_for_new_repository
}

j() {
    z "$@"
    check_directory_for_new_repository
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

#if type zellij > /dev/null 2>&1
#then
#	export ZELLIJ_AUTO_ATTACH=false
#	if [[ $TERM_PROGRAM != vscode ]]; then
#  		eval "$(zellij setup --generate-auto-start zsh)"
#	fi
#fi

if type pyenv > /dev/null 2>&1
then
	export PYENV_ROOT="$HOME/.pyenv"
	[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"
fi

eval "$(starship init zsh)"

