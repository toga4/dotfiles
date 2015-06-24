export EDITOR='vim'

# prompt ---------------------------------------------------------------
autoload -Uz colors
colors

# COLORS
RESET="%{${reset_color}%}"
GREEN="%{${fg[green]}%}"
BLUE="%{${fg[blue]}%}"
RED="%{${fg[red]}%}"
CYAN="%{${fg[cyan]}%}"
YELLOW="%{${fg[yellow]}%}"
WHITE="%{${fg[white]}%}"

PROMPT="${BLUE}%n${RESET}@%U%m%u%# "
RPROMPT="${GREEN}%~${RESET} [${RED}%?${RESET}][%D %T]"

# alias ----------------------------------------------------------------
alias ls='ls -AGFh'
alias ll='ls -l'

alias du="du -h"
alias df="df -h"

alias psa='ps aux'

alias less='less -r'

# key binding ----------------------------------------------------------
bindkey "\e[Z" reverse-menu-complete # 逆補完
bindkey "^[[3~" delete-char

# 補完 -----------------------------------------------------------------
autoload -U compinit;
compinit

# 大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 候補をハイライト
zstyle ':completion:*:default' menu select=2

# 補完関数の表示を強化する
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format ${YELLOW}'%d'${RESET}
zstyle ':completion:*:warnings' format ${RED}'No matches for:'${YELLOW}' %d'${RESET}
zstyle ':completion:*:descriptions' format ${YELLOW}'completing %B%d%b'${RESET}
zstyle ':completion:*:options' description 'yes'

# マッチ種別を別々に表示
zstyle ':completion:*' group-name ''

# 今いるディレクトリを補完候補から外す
zstyle ':completion:*' ignore-parents parent pwd ..

# option ---------------------------------------------------------------
setopt nolistbeep # beepを鳴らさないようにする
setopt multios # 複数のリダイレクトやパイプなど、必要に応じて tee や cat の機能が使われる
setopt auto_cd # 指定したコマンド名がなく、ディレクトリ名と一致した場合 cd する
setopt auto_pushd # 自動的にpushdする 
setopt pushd_ignore_dups # ディレクトリスタックに同じディレクトリを追加しないようになる
setopt correct # コマンドのスペルチェックをする
setopt correct_all # コマンドライン全てのスペルチェックをする 
setopt no_clobber # 上書きリダイレクトの禁止
setopt list_packed # 補完候補リストを詰めて表示
setopt list_types # auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示
setopt auto_list # 補完候補が複数ある時に、一覧表示する
setopt magic_equal_subst # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt auto_param_keys # カッコの対応などを自動的に補完する
setopt auto_param_slash # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt extended_glob # glob拡張
setopt globdots # 明確なドットの指定なしで.から始まるファイルをマッチ
setopt brace_ccl # {a-c} を a b c に展開する機能を使えるようにする
setopt auto_menu # 補完キー（Tab,  Ctrl+I) を連打するだけで順に補完候補を自動で補完する
setopt noautoremoveslash # 最後がディレクトリ名で終わっている場合末尾の / を自動的に取り除かない
setopt mark_dirs # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加

# sudoも補完の対象
#zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# 色付きで補完する
zstyle ':completion:*' list-colors di=34 fi=0

# history --------------------------------------------------------------
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

setopt share_history # 履歴を共有する
setopt hist_ignore_dups # 重複を記録しない
setopt hist_ignore_all_dups # 重複するコマンドは古いものを削除する
setopt append_history # 複数のzshを同時に使用した際に履歴ファイルを上書きせず追加する
setopt hist_verify # ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_save_no_dups # ファイルに書き出すとき古いコマンドと同じなら無視
setopt hist_no_store # historyコマンドは履歴に追加しない

# 全履歴表示
function history-all { history -E 1 }

# 略語展開 -------------------------------------------------------------
# vimのiabみたいな略語展開をする
typeset -A abbreviations
abbreviations=(
    "i-test"	"verify -Dtest=TestNameDoNotMatch -DfailIfNoTests=false"
)

magic-abbrev-expand() {
    local MATCH
    LBUFFER=${LBUFFER%%(#m)[-_a-zA-Z0-9]#}
    LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
    zle self-insert
}

no-magic-abbrev-expand() {
    LBUFFER+=' '
}

zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand
bindkey " " magic-abbrev-expand
bindkey "^x " no-magic-abbrev-expand

# .zshrc.local ---------------------------------------------------------
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
[ -f ~/.zshrc.tmux ] && source ~/.zshrc.tmux

