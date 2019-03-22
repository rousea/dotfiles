#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

EDITOR=/usr/bin/vim
PS1="\[\e[01;35m\]\t \[\e[m\]\\[\e[33m\]\W\[\e[m\] > "
PS2='> '

if [[ $(uname) == "Darwin" ]]; then
  BROWSER=/Applications/Firefox.app

  PATH=$PATH:$HOME/Library/Android/sdk/platform-tools/

  alias uart="sudo screen /dev/tty.usbserial 115200"
  alias lock="pmset displaysleepnow"
  export CLICOLOR=1
  export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"

  ssh-add -K > /dev/null 2>&1
  ssh-add -L > /dev/null 2>&1

  if [[ -f utils/adbhelpers.sh ]]; then
    source utils/adbhelpers.sh
  fi

  export GOPATH=/Users/arouse/workspace/go
  alias ls='ls -lh'
elif [[ $(uname) == "Linux" ]]; then
  # nothing yet
  BROWSER=/usr/bin/chromium
  alias ls='ls -lh --color=auto'
  eval `dircolors ~/.dircolors/dircolors.256dark`
fi
