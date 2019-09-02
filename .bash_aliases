#
# ~/.bash_aliases
#

case "$OSTYPE" in
   msys)
       alias open="start"
       source ~/.bash_aliases_windows
   	  ;;
   linux*)
      alias start="xdg-open"
      alias open="xdg-open"
      alias ls='ls --color=auto'
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
alias aliases="vim ~/.bash_aliases && source ~/.bash_aliases"
alias functions="vim ~/.bash_functions && source ~/.bash_functions"
alias h="cd ~"
alias clear='printf "\33[2J"'
alias cclear='/usr/bin/clear'
alias cls='clear'
alias printenv='printenv | grep -e LS_COLORS -v | sort'
alias xclip='xclip -selection clipboard'
alias dotnet="TERM=xterm dotnet"
alias work='cd ~/src/work && ll'
alias github='cd ~/src/github && ll'
alias gitlab='cd ~/src/gitlab && ll'
alias cat=bat
alias branchowners="git for-each-ref --format='%(committerdate) %09 %(authorname) %09 %(refname)' | sort -k5n -k2M -k3n -k4n"
alias gosrc="cd $GOPATH/src/"
alias swayconfig="vim $HOME/.config/sway/config"
alias tf=terraform

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias mitmproxy="docker run --rm -it -v ~/.mitmproxy:/home/mitmproxy/.mitmproxy -p 8080:8080 mitmproxy/mitmproxy"
alias mitmweb="docker run --rm -it -v ~/.mitmproxy:/home/mitmproxy/.mitmproxy -p 8080:8080 -p 8081:8081 mitmproxy/mitmproxy mitmweb --web-iface 0.0.0.0"

if uname -a | grep -q Microsoft || uname -a | grep -q Ubuntu
then
    alias update="sudo snap refresh; sudo apt-get update && sudo apt-get upgrade --with-new-pkgs -y && sudo apt-get autoremove -y"
elif [ -f "/etc/os-release" ] && grep -Fq "Fedora" /etc/os-release
then
    alias update="sudo snap refresh && sudo dnf upgrade -y"
else
    alias update="aurman -Syu --noconfirm"
fi

if [ "$OSTYPE" == "msys" ]
then
    alias oktad="winpty oktad"
    alias vault="winpty vault"
    alias mitmproxy='winpty docker run --rm -it -v "~//.mitmproxy:/home/mitmproxy/.mitmproxy" -p 8080:8080 mitmproxy/mitmproxy'
    alias mitmweb='winpty docker run --rm -it -v "~//.mitmproxy:/home/mitmproxy/.mitmproxy" -p 8080:8080 -p 127.0.0.1:8081:8081 mitmproxy/mitmproxy mitmweb --web-iface 0.0.0.0'
fi

alias topten="history | awk '{print $2}' | sort | uniq -c | sort -rn | head -10"
alias redis-cli='docker run --rm -it mapitman/redis-cli'
