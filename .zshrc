### PATH ###
# go
export GOPATH="$HOME/.gocode"
PATH="$GOPATH/bin:$PATH"

# ruby
eval "$(rbenv init -)"

# ruby-build
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

# java
export JAVA_HOME=$(jenv javahome)
eval "$(jenv init -)"

# nodejs
eval "$(nodenv init -)"

# gcloud
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc

# path
export PATH="$HOME/bin:$PATH"

### その他 ###

export LANG=ja_JP.UTF-8

# 履歴
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=10000
# 履歴の連続する同じコマンドを除去
setopt hist_ignore_dups
# 履歴の無駄な空白を除去
setopt hist_reduce_blanks
# zshプロセス間で履歴を共有
# setopt share_history

# colors
autoload -Uz colors
colors

# syntax-highlighting
. "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# autosuggestions
. "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='underline'

### 補完機能 ###

## zsh-completionsを利用
fpath=($(brew --prefix docker)/share/zsh/site-functions $fpath)
fpath=($(brew --prefix)/share/zsh-completions $fpath)

autoload -Uz compinit
compinit -u
# moshはsshの補完を利用
compdef mosh=ssh
# awscli
#source `brew --prefix`/bin/aws_zsh_completer.sh
## 補完候補をTab, C-f, b, n, p, 矢印で選択(C-n, pはなぜかhistory-search-endにとられる)
zstyle ':completion:*:default' menu select=2
## Shift-Tabで補完候補の逆順選択(いきなりmenu-completeが始まるのが気に入らない)
bindkey "^[[Z" reverse-menu-complete

# gcloud
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc

### history-search-end ###

# history-search-endで前方一致コマンド履歴をたどる時カーソルを行末に
autoload -Uz history-search-end
## zsh line editor(zle)に登録
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
## キーバインド(^[[Aは上、^[[Bは下矢印。zshでCtrl-Vすれば調べられる)
bindkey "^P" history-beginning-search-backward-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey "^[[B" history-beginning-search-forward-end

### zshコマンド ###

# zmv
autoload -Uz zmv
## クオート省略、グループ化括弧省略
# alias zmv='noglob zmv -W'

# zargs
autoload -Uz zargs

### z ###
. "$(brew --prefix)/etc/profile.d/z.sh"

### peco ###

# Search shell history with peco: https://github.com/peco/peco
# Adapted from: https://github.com/mooz/percol#zsh-history-search
if which peco &> /dev/null; then
  function peco_select_history() {
    BUFFER=$(fc -r -l -n 1 | peco --layout=bottom-up --query "$LBUFFER")
    CURSOR=$#BUFFER # move cursor
    zle -R -c       # refresh
  }
 
  zle -N peco_select_history
  bindkey '^R' peco_select_history
fi


### プロンプト ###

# vcs_info
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%s][*%F{green}%b%f]:'
zstyle ':vcs_info:*' actionformats '[%s][*%F{green}%b%f(%F{red}%a%f)]:'

# プロンプトで変数展開などを有効に
setopt prompt_subst
# 左プロンプト %n:ユーザ名 %m:マシン名 %~:カレントディレクトリ
precmd() { vcs_info }
PROMPT='${vcs_info_msg_0_}%~$%f '
# 右プロンプト %T:現在時刻
RPROMPT='%T'
# コマンド実行時に右プロンプトを消す
#setopt transient_rprompt

### alias, default option ###
alias ls="ls -FG"
alias rm="trash"
export LESS='-R'

. ~/.bin/teleport.sh

### tmux ###

# ウィンドウ名をカレントディレクトリ+Gitリポジトリルートに
autoload -Uz add-zsh-hook
. ~/.bin/show-current-dir-as-window-name.sh
add-zsh-hook precmd show-current-dir-as-window-name
add-zsh-hook preexec show-current-dir-as-window-name

### Capybara-Webkit
# export PATH="$HOME/Qt5.5.0/5.5/clang_64/bin:$PATH"
