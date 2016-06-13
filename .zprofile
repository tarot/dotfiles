export PATH="$HOME/bin:$HOME/.gocode/bin:/usr/local/bin:$PATH"
eval "$(rbenv init -)"
eval "$(jenv init -)"

export GOPATH="$HOME/.gocode"
export NODE_PATH=$(npm root -gs)
export JAVA_HOME=$(jenv javahome)
export ANDROID_HOME="$(brew --prefix android-sdk)"
export RUBYMOTION_ANDROID_SDK="$(brew --prefix android-sdk)"
export RUBYMOTION_ANDROID_NDK="$(brew --prefix android-ndk)"
