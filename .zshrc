### PATH ###

# ~/.bin
export PATH="$HOME/.bin:$PATH"

### その他 ###

export LANG=ja_JP.UTF-8

# 履歴
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=100000
# 履歴の連続する同じコマンドを除去
setopt hist_ignore_dups
# 履歴の無駄な空白を除去
setopt hist_reduce_blanks
# zshプロセス間で履歴を共有
setopt share_history

# colors
autoload -Uz colors
colors

### 補完機能 ###

# zsh-completionsを利用
FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

autoload -Uz compinit
compinit -u

# 補完候補をTab, C-f, b, n, p, 矢印で選択(C-n, pはなぜかhistory-search-endにとられる)
zstyle ':completion:*:default' menu select=2

# Shift-Tabで補完候補の逆順選択(いきなりmenu-completeが始まるのが気に入らない)
bindkey "^[[Z" reverse-menu-complete

### history-search-end ###

# history-search-endで前方一致コマンド履歴をたどる時カーソルを行末に
autoload -Uz history-search-end

# zsh line editor(zle)に登録
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# キーバインド(^[[Aは上、^[[Bは下矢印。zshでCtrl-Vすれば調べられる)
bindkey "^P" history-beginning-search-backward-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey "^[[B" history-beginning-search-forward-end

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

### alias, default option ###
alias ls="ls -FG"
export LESS='-R'

. ~/.bin/teleport.sh

### mise
eval "$($(brew --prefix)/bin/mise activate zsh)"

### salesfoce/cli autocomplete
eval $(sf autocomplete script zsh)
