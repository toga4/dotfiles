[ -f ~/.zshrc.tmux ] && source ~/.zshrc.tmux

export PATH="$HOME/bin:$PATH"

export EDITOR='vim'
export LESS='-gj10 --no-init --quit-if-one-screen --RAW-CONTROL-CHARS'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --extended --cycle --multi'

# prompt colors --------------------------------------------------------
autoload -Uz colors
colors

RESET="%{${reset_color}%}"
GREEN="%{${fg[green]}%}"
BLUE="%{${fg[blue]}%}"
RED="%{${fg[red]}%}"
CYAN="%{${fg[cyan]}%}"
YELLOW="%{${fg[yellow]}%}"
WHITE="%{${fg[white]}%}"

# key binding ----------------------------------------------------------
bindkey -d
bindkey -e

bindkey "^[[Z" reverse-menu-complete # 逆補完
bindkey "^[[3~" delete-char

bindkey "^[^[[D" backward-word # Alt + <-
bindkey "^[^[[C" forward-word # Alt + ->
bindkey "^[[1~" beginning-of-line # Home
bindkey "^[[4~" end-of-line # End

# word移動の区切り文字を設定 -------------------------------------------
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /;@"
zstyle ':zle:*' word-style unspecified

# 履歴 -----------------------------------------------------------------
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

# 全履歴表示
function history-all { history -E 1 }

# import ---------------------------------------------------------------
[ -f ~/.zshrc.prompt ] && source ~/.zshrc.prompt
[ -f ~/.zshrc.completion ] && source ~/.zshrc.completion
[ -f ~/.zshrc.options ] && source ~/.zshrc.options
[ -f ~/.zshrc.alias ] && source ~/.zshrc.alias
[ -f ~/.zshrc.functions ] && source ~/.zshrc.functions
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

