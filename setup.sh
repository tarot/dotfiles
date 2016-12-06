for e in .gitconfig .gitignore_global .tmux.conf .zshrc .peco .bin
do
    if [ -e ~/"$e" ]; then
        rm -r ~/"$e"
    fi
    ln -s "$(pwd)"/"$e" ~/"$e"
done
