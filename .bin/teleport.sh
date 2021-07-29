#!/usr/local/bin/zsh
function teleport() {
    COMMAND='kill $(ps x | grep /Applications/teleport.app/Contents/MacOS/teleport | grep -v grep | awk '\''{print $1}'\'') > /dev/null 2>&1 ; open -a teleport'
    HOST=$1
    if [ -n "${HOST}" ]; then
        ssh $HOST ${COMMAND}
    else
        eval ${COMMAND}
    fi
}
