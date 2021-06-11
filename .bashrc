#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

function __opt_source {
  if [[ -f $1 ]]; then
    source $1
  fi
}

EDITOR=/usr/bin/vim

HISTSIZE=10000

export TMUX_VERSION=$(tmux -V | sed -En 's/^tmux ([0-9]+(.[0-9]+)?).*/\1/p')

alias scrcpy="(scrcpy --shortcut-mod=lctrl &>/dev/null &)"

alias ll='ls -lh'
alias lla='ls -lha'
alias ls='ls --color=auto'

__opt_source /usr/share/bash-completion/bash_completion

alias grep="grep --color"

MAX_PWD_LENGTH=30
function shorten_pwd {
  # determine part of path within HOME, or entire path if not in HOME
  # remove $HOME from $PWD
  local RESIDUAL=${PWD#$HOME}

  # compare RESIDUAL with PWD to determine whether we are in HOME or not
  if [ X"$RESIDUAL" != X"$PWD" ]
  then
    local PREFIX="~"
  fi

  # check if residual path needs truncating to keep total length below MAX_PWD_LENGTH
  local NORMAL=${PREFIX}${RESIDUAL}

  if [ ${#NORMAL} -ge $(($MAX_PWD_LENGTH)) ]
  then
    local NEW=${PREFIX}
    local OIFS=$IFS
    local IFS='/'
    local bits=$RESIDUAL
    for dir in $bits
    do
      test -z "$dir" && continue
      local NEXT="/${dir:0:1}"
      local NEW="$NEW$NEXT"
    done


    # remove final letter, replace with dir
    NEW="${NEW%$NEXT}"
    NEW="$NEW/$dir"

    local IFS=$OIFS
  else
    local NEW=${PREFIX}${RESIDUAL}
  fi

  echo $NEW
}

if [[ $(uname) == "Darwin" ]]; then
  BROWSER=/Applications/Firefox.app

  PATH=$PATH:/usr/local/sbin/:$HOME/Library/Android/sdk/platform-tools/
  PATH=/usr/local/opt/openjdk@11/bin:$PATH

  alias uart="sudo screen /dev/tty.usbserial 115200"
  alias lock="pmset displaysleepnow"
  export CLICOLOR=1
  export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"

  ssh-add -K > /dev/null 2>&1
  ssh-add -L > /dev/null 2>&1

  __opt_source $HOME/utils/adbhelpers.sh

  export GOPATH=/Users/arouse/workspace/go

  PS1="\[\e[01;34m\]\t \[\e[m\]\\[\e[32m\]\W\[\e[m\] > "
  PS2='> '

  source $(brew --prefix)/etc/bash_completion.d/git-completion.bash
elif [[ $(uname) == "Linux" ]]; then

  source /usr/share/git/completion/git-completion.bash
  source /usr/share/git/completion/git-prompt.sh
  source /usr/share/fzf/key-bindings.bash
  source /usr/share/fzf/completion.bash

  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

  PATH=$PATH:$HOME/Android/Sdk/platform-tools/
  PATH=$HOME/.local/bin:$PATH
  __opt_source $HOME/workspace/utils/adbhelpers

  # TODO: add support for error code
  gitprompt='$(__git_ps1 " (%s)")'
  shorten='$(shorten_pwd)'
  PS1=" \[\e[00;32m\]$shorten\[\e[00;33m\]$gitprompt \[\e[0m\]$ "
  PS2='> '
  unset gitprompt
  eval `dircolors ~/.dircolors/dircolors.nord`
fi

