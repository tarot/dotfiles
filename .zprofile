export PATH="$HOME/bin:$HOME/.nodebrew/current/bin:$HOME/.gocode/bin:/usr/local/bin:$PATH"
eval "$(rbenv init -)"
eval "$(jenv init -)"

export GOPATH="$HOME/.gocode"
export JAVA_HOME=$(jenv javahome)
export ANDROID_HOME="$(brew --prefix android-sdk)"
