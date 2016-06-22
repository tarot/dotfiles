for e in .gitconfig .gitignore_global .tmux.conf .zprofile .zshrc .peco
do
    rm -r ~/"$e"
    ln -s "$(pwd)"/"$e" ~/"$e"
done
