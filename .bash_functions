# ~/.bash_functions

function loadavg() {
    awk '{ printf("1-minute: %s\n5-minute: %s\n15-minute: %s\n",$1,$2,$3); }' /proc/loadavg
}

rider ()
{
    case "$OSTYPE" in
        msys)
            rider=rider64
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



if uname -a | grep -q microsoft
then
    vs()
    {
        vs_command=/mnt/c/Program\ Files\ \(x86\)/Microsoft\ Visual\ Studio/2019/Professional/Common7/IDE/devenv.exe
        files=(./*.sln)
        
        if [ -e ${files[0]} ]
        then
            "$vs_command" ${files[0]} &
        else
            files=(./*.csproj)
            if [ -e ${files[0]} ]
            then
                "$vs_comand" ${files[0]} &
            fi
        fi
    }
fi
