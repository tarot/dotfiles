#!/usr/local/bin/zsh
function current-dir-with-git-root() {
    PWD_T=${PWD:t}
    GIT_ROOT=$(git rev-parse --show-toplevel 2> /dev/null)
    if [ $? -gt 0 ]; then
        echo "${PWD_T}"
    elif [ "$(basename ${GIT_ROOT})" = "${PWD_T}" ]; then
        echo "[git][$(basename ${GIT_ROOT})]:."
    else
        echo "[git][$(basename ${GIT_ROOT})]:${PWD:t}"
    fi
}
function show-current-dir-as-window-name() {
    tmux rename-window "$(current-dir-with-git-root)" >& /dev/null
}
show-current-dir-as-window-name