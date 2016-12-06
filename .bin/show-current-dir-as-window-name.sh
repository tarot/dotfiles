#!/usr/local/bin/zsh
function current-dir-with-git-root() {
    GIT_ROOT=$(git rev-parse --show-toplevel 2> /dev/null)
    if [ $? -gt 0 ]; then
        echo "${PWD:t}"
    else
        echo "[git][$(basename ${GIT_ROOT})]:${PWD:t}"
    fi
}
function show-current-dir-as-window-name() {
    tmux rename-window "$(current-dir-with-git-root)" >& /dev/null
}
show-current-dir-as-window-name