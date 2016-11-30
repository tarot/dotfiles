# go
export GOPATH="$HOME/.gocode"
PATH="$GOPATH/bin:$PATH"

# ruby
eval "$(rbenv init -)"

# java
export JAVA_HOME=$(jenv javahome)
eval "$(jenv init -)"

# nodejs
PATH="$HOME/.nodebrew/current/bin:$PATH"

# android sdk
export ANDROID_HOME="$(brew --prefix android-sdk)"

# path
export PATH="$HOME/bin:$PATH"
