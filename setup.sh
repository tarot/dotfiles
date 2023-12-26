for e in .gitconfig .gitignore_global .zshrc .zprofile .peco .bin
do
    if [ -e ~/"$e" ]; then
        rm -r ~/"$e"
    fi
    ln -s "$(pwd)"/"$e" ~/"$e"
done
