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
alias ls='ls -aGFh'
alias ll='ls -l'

alias du="du -h"
alias df="df -h"

alias psa='ps aux'

alias less='less -r'

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

# option ---------------------------------------------------------------
# 指定したコマンド名がなく、ディレクトリ名と一致した場合 cd する
setopt auto_cd

# 自動的にpushdする
setopt auto_pushd

# ディレクトリスタックに同じディレクトリを追加しないようになる
setopt pushd_ignore_dups

# コマンドのスペルチェックをする
setopt correct

# コマンドライン全てのスペルチェックをする
setopt correct_all

# 上書きリダイレクトの禁止
setopt no_clobber

# 補完候補リストを詰めて表示
setopt list_packed

# auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示
setopt list_types

# 補完候補が複数ある時に、一覧表示する
setopt auto_list

# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst

# カッコの対応などを自動的に補完する
setopt auto_param_keys

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl

# シンボリックリンクは実体を追うようになる
#setopt chase_links

# 補完キー（Tab,  Ctrl+I) を連打するだけで順に補完候補を自動で補完する
setopt auto_menu

# sudoも補完の対象
#zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# 色付きで補完する
zstyle ':completion:*' list-colors di=34 fi=0
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 複数のリダイレクトやパイプなど、必要に応じて tee や cat の機能が使われる
setopt multios

# 最後がディレクトリ名で終わっている場合末尾の / を自動的に取り除かない
setopt noautoremoveslash

# beepを鳴らさないようにする
setopt nolistbeep
