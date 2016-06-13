export LANG=ja_JP.UTF-8

# プロンプトで変数展開などを有効に
setopt prompt_subst
# 左プロンプト %n:ユーザ名 %m:マシン名 %~:カレントディレクトリ
PROMPT="%n@%m:%~$ "
# 右プロンプト %T:現在時刻
#RPROMPT="%T"
# コマンド実行時に右プロンプトを消す
#setopt transient_rprompt

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

# 補完機能
## zsh-completionsを利用
fpath=($(brew --prefix)/share/zsh-completions $fpath)
autoload -Uz compinit
compinit
# moshはsshの補完を利用
compdef mosh=ssh
# awscli
#source `brew --prefix`/bin/aws_zsh_completer.sh
## 補完候補をTab, C-f, b, n, p, 矢印で選択(C-n, pはなぜかhistory-search-endにとられる)
zstyle ':completion:*:default' menu select=2
## Shift-Tabで補完候補の逆順選択(いきなりmenu-completeが始まるのが気に入らない)
bindkey "^[[Z" reverse-menu-complete

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

# zmv
autoload -Uz zmv
## クオート省略、グループ化括弧省略
# alias zmv='noglob zmv -W'

# zargs
autoload -Uz zargs

# z
source `brew --prefix`/etc/profile.d/z.sh

# colors
autoload -Uz colors
colors

# direnv
#eval "$(direnv hook zsh)"

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

alias ls="ls -FG"
alias mitmproxy="mitmproxy --palette solarized_light"
alias rm="trash"
export LESS='-R'
