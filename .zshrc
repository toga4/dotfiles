function tmux_automatically_attach_session()
{
  # skip if tmux is not installed
  [[ ! -x `which tmux` ]] && echo "tmux is not installed" && return 1
  # skip if shell level != 1
  [[ $SHLVL != "1" ]] && return 0
  # skip if terminal on vscode
  [[ $TERM_PROGRAM = "vscode" ]] && return 0
  # skip if shell is not running interactively
  [[ -z $PS1 ]] && return 0

  # tmux attach が少し遅いので list-sessions する
  if $(tmux list-sessions > /dev/null 2>&1); then
    tmux attach
  else
    tmux new-session
  fi
}
tmux_automatically_attach_session

########################################################################
# prompt
########################################################################
autoload -Uz colors
colors

RESET="%{${reset_color}%}"
GREEN="%{${fg[green]}%}"
BLUE="%{${fg[blue]}%}"
RED="%{${fg[red]}%}"
CYAN="%{${fg[cyan]}%}"
YELLOW="%{${fg[yellow]}%}"
WHITE="%{${fg[white]}%}"

autoload -Uz vcs_info
autoload -Uz add-zsh-hook

setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "!"
zstyle ':vcs_info:git:*' unstagedstr "+"
zstyle ':vcs_info:git:*' formats '[%c%u%b]'
zstyle ':vcs_info:git:*' actionformats '[%c%u%b|%a]'
function _update_vcs_info_msg() {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="${vcs_info_msg_0_} "
}
add-zsh-hook precmd _update_vcs_info_msg

PROMPT='${GREEN}%~${RESET} %1v[${RED}%?${RESET}]
%# '

########################################################################
# key binding
########################################################################
bindkey -d
bindkey -e

bindkey "^[[Z" reverse-menu-complete # 逆補完
bindkey "^[[3~" delete-char

bindkey "^[^[[D" backward-word # Alt + <-
bindkey "^[^[[C" forward-word # Alt + ->
bindkey "^[[1~" beginning-of-line # Home
bindkey "^[[4~" end-of-line # End

# word移動の区切り文字を設定
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /;@"
zstyle ':zle:*' word-style unspecified

########################################################################
# Completion
########################################################################
fpath=(~/zsh/completions $fpath)
autoload -U compinit;
compinit -u

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

# sudoも補完の対象
#zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# 色付きで補完する
zstyle ':completion:*' list-colors di=34 fi=0

########################################################################
# ZSH Options
########################################################################
# Changing Directories
setopt    auto_cd                 # 指定したコマンド名がなく、ディレクトリ名と一致した場合 cd する
setopt    auto_pushd              # 自動的にpushdする
setopt    pushd_ignore_dups       # ディレクトリスタックに同じディレクトリを追加しないようになる

# Completions
setopt    auto_list               # 補完候補が複数ある時に、一覧表示する
setopt    auto_menu               # 補完キー（Tab,  Ctrl+I) を連打するだけで順に補完候補を自動で補完する
setopt    auto_param_keys         # カッコの対応などを自動的に補完する
setopt    auto_param_slash        # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
unsetopt  auto_remove_slash       # 最後がディレクトリ名で終わっている場合末尾の / を自動的に取り除かない
setopt    complete_aliases        # aliasでも補完する
unsetopt  list_beep               # beepを鳴らさないようにする
setopt    list_packed             # 補完候補リストを詰めて表示
setopt    list_types              # auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示

# Expansion and Globbing
setopt    brace_ccl               # {a-c} を a b c に展開する機能を使えるようにする
unsetopt  extended_glob           # glob拡張
setopt    globdots                # 明確なドットの指定なしで.から始まるファイルをマッチ
setopt    magic_equal_subst       # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt    mark_dirs               # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加

# History
unsetopt  flow_control            # C-sでフロー制御しないようにする
setopt    append_history          # 複数のzshを同時に使用した際に履歴ファイルを上書きせず追加する
setopt    hist_ignore_all_dups    # 重複するコマンドは古いものを削除する
setopt    hist_ignore_dups        # 重複を記録しない
setopt    hist_no_store           # historyコマンドは履歴に追加しない
setopt    hist_save_no_dups       # ファイルに書き出すとき古いコマンドと同じなら無視
setopt    hist_verify             # ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt    share_history           # 履歴を共有する

# Input/Output
setopt    clobber                 # 上書きリダイレクトの禁止を解除
setopt    correct                 # コマンドのスペルチェックをする
unsetopt  correct_all             # コマンドライン全てのスペルチェックをする
setopt    ignore_eof              # Ctrl+Dでログアウトしない(10回連続で打つとログアウトする)
setopt    interactivecomments     # コマンドラインでも "#" でコメントアウト可能にする

# Scripts and Functions
setopt    multios                 # 複数のリダイレクトやパイプなど、必要に応じて tee や cat の機能が使われる

# functions
function showoptions() {
  set -o | sed -e 's/^no\(.*\)on$/\1  off/' -e 's/^no\(.*\)off$/\1  on/'
}

########################################################################
# history
########################################################################
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

# 全履歴表示
function history-all { history -E 1 }

########################################################################
# alias
########################################################################
case ${OSTYPE} in
  darwin*)
    alias ls='ls -AGFh'
    ;;
  linux*|cygwin*|msys*)
    alias ls='ls -AFh --color'
    ;;
esac
alias ll='ls -l'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias du="du -h"
alias df="df -h"

alias psa='ps aux'

if [[ -x `which colordiff` ]];then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi

# k9s
alias k9s='LANG=en_US.UTF-8 k9s'

########################################################################
# others
########################################################################
typeset -Ug fpath path PATH

export PATH="$HOME/bin.local:$HOME/bin:$PATH"
export EDITOR='vim'
export LESS='-gj10 --no-init --quit-if-one-screen --RAW-CONTROL-CHARS'

fpath=(~/zsh/functions $fpath)
autoload -Uz $(\ls -1 ~/zsh/functions)

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --extended --cycle --multi'

# golang
export GOPATH=$(go env GOPATH)
export PATH="$PATH:${GOPATH}/bin"

# asdf
source $(brew --prefix asdf)/asdf.sh


########################################################################
# plugins
########################################################################
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# Two regular plugins loaded without investigating.
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
