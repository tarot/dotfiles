for e in .gitconfig .gitignore_global .tmux.conf .zprofile .zshrc .peco
do
    if [ -e ~/"$e" ]; then
        rm -r ~/"$e"
    fi
    ln -s "$(pwd)"/"$e" ~/"$e"
done
